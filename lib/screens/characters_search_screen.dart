import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/models/character/character.dart';
import 'package:marvel_app/widgets/character_tile.dart';

class CharactersSearchScreen extends ConsumerStatefulWidget {
  const CharactersSearchScreen({Key? key}) : super(key: key);

  @override
  _CharactersSearchScreenState createState() => _CharactersSearchScreenState();
}

class _CharactersSearchScreenState
    extends ConsumerState<CharactersSearchScreen> {
  String? _searchTerm;
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
      ref
          .read(charactersSearchProvider)
          .fetchCharacters(_searchTerm!, doesNotify: false);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Character> characters = ref.watch(charactersSearchProvider).characters;
    int offset = ref.watch(charactersSearchProvider).offset;
    if (characters.isNotEmpty) {
      _pagingController.value = PagingState<int, Character>(
        nextPageKey: offset,
        itemList: characters,
      );
    }
    if (!ref.watch(charactersSearchProvider).hasNext) {
      _pagingController.appendLastPage([]);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text('Character'),
                hintText: 'E.g. Spider Man',
              ),
              onSubmitted: (value) {
                setState(() => _searchTerm = value);
                // empty characters (so that new values are not added on old
                // search characters) list, reset offset, total and count in the
                // provider
                ref.read(charactersSearchProvider).refresh();
                // refresh the PagingController so that the value of nextPageKey
                // is zero so that it fetches the 1st page and go through the
                // infinite scroll process again (if there are some characters
                // already fetched and viewed)
                _pagingController.refresh();
              },
            ),
            SizedBox(height: 20),
            if (_searchTerm != null)
              Expanded(
                child: PagedGridView<int, Character>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, character, index) =>
                        CharacterTile(character),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              ),
          ],
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
