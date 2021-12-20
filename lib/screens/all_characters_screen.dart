import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/models/character/character.dart';
import 'package:marvel_app/screens/character_details_screen.dart';
import 'package:marvel_app/screens/characters_search_screen.dart';
import 'package:marvel_app/widgets/character_tile.dart';

class AllCharactersScreen extends ConsumerStatefulWidget {
  const AllCharactersScreen({Key? key}) : super(key: key);

  @override
  _AllCharactersScreenState createState() => _AllCharactersScreenState();
}

class _AllCharactersScreenState extends ConsumerState<AllCharactersScreen> {
  final PagingController<int, Character> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CharactersSearchScreen()));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: PagedGridView<int, Character>(
        pagingController: _pagingController,
        padding: EdgeInsets.all(7),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 7,
          crossAxisSpacing: 7,
        ),
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, character, index) => CharacterTile(character),
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
