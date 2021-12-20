import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_app/marvel_repository.dart';
import 'package:marvel_app/models/character.dart';

enum LoadingState { loading, done }

void main() {
  runApp(ProviderScope(
    child: const MyApp(),
    // child: const MyPaginatedApp(),
  ));
}

final charactersProvider = ChangeNotifierProvider<CharacterListProvider>((ref) {
  return CharacterListProvider();
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Marvel App')),
        body: CharactersListView(),
      ),
    );
  }
}

class CharactersListView extends ConsumerStatefulWidget {
  const CharactersListView({Key? key}) : super(key: key);

  @override
  _CharactersListViewState createState() => _CharactersListViewState();
}

class _CharactersListViewState extends ConsumerState<CharactersListView> {
  final PagingController<int, Character> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      print('fetching new page, offset: $pageKey');
      ref.read(charactersProvider).fetchCharacters(doesNotify: false);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Character> characters = ref.watch(charactersProvider).characters;
    int offset = ref.watch(charactersProvider).offset;
    // shouldn't set the PagingController.value manually at the first page so
    // that the controller can request the first page and show the loading
    // indicator instead of the no elements found text
    if (characters.isNotEmpty) {
      _pagingController.value = PagingState<int, Character>(
        nextPageKey: offset,
        itemList: characters,
      );
    }
    // should tell the controller to stop requesting pages if there is no
    // further pages
    if (!ref.watch(charactersProvider).hasNext) {
      _pagingController.appendLastPage([]);
    }
    return PagedGridView<int, Character>(
      pagingController: _pagingController,
      padding: EdgeInsets.all(7),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 7,
        crossAxisSpacing: 7,
      ),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, character, index) => GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CharacterDetails(character))),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            elevation: 6,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      character.thumbnail.url,
                      width: double.infinity,
                      fit: character.thumbnail.boxFit,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) {
                          return child;
                        } else if (progress.expectedTotalBytes == null) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          double doubleProg = progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes!;
                          return Center(
                            child: CircularProgressIndicator(value: doubleProg),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          Text(error.toString()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(character.name, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class CharacterDetails extends StatelessWidget {
  final Character character;
  const CharacterDetails(this.character, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          character.name,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7),
            child: Image.network(
              character.thumbnail.url,
              width: double.infinity,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                } else if (progress.expectedTotalBytes == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  double doubleProg = progress.cumulativeBytesLoaded /
                      progress.expectedTotalBytes!;
                  return Center(
                    child: CircularProgressIndicator(value: doubleProg),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) =>
                  Text(error.toString()),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Text(
                  character.name,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
                Text(character.description.isNotEmpty
                    ? character.description
                    : 'No available description'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
