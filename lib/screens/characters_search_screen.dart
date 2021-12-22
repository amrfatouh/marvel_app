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
    _pagingController.addPageRequestListener((int pageKey) async {
      try {
        print('fetching new page, offset: $pageKey');
        ref
            .read(charactersSearchProvider)
            .fetchCharacters(_searchTerm!, doesNotify: false);
      } catch (error) {
        _pagingController.error = error;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CharacterListSearchProvider>(charactersSearchProvider,
        (previous, next) {
      _pagingController.value = PagingState<int, Character>(
        nextPageKey: next.hasNext ? next.offset : null,
        itemList: next.characters,
      );
    });

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
                // empty characters list (so that new values are not added on
                // old search characters), reset offset, total and count in the
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
