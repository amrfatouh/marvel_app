import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/models/character/character.dart';
import 'package:marvel_app/screens/characters_search_screen.dart';
import 'package:marvel_app/widgets/character_tile.dart';

/*
summary of setting up infinite scrolling with infinite_scroll_package:
----------------------------------------------------------------------
- add the PagingController to the List of the Grid Views
- add a page request listener in initState() that tells the provider to fetch a
  new page
- add a listener in the build method to set the value of the PagingController
  with each change in the provider
- for searching if you want to reset everythingf for a new search term, invoke
  PagingController.refresh() and create a method in the provider to reset all
  values to initial values and invoke it BEFORE PagingController.refresh()
*/

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
    _pagingController.addPageRequestListener((int pageKey) async {
      try {
        ref.read(charactersProvider).fetchCharacters(doesNotify: false);
      } catch (error) {
        _pagingController.error = error;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Update the PagingController.value when the provider changes.
    // Passing null to nextPageKey tells the PagingController to stop making
    // further page requests.
    ref.listen<CharacterListProvider>(charactersProvider, (previous, next) {
      _pagingController.value = PagingState<int, Character>(
        nextPageKey: next.hasNext ? next.offset : null,
        itemList: next.characters,
      );
    });

    /// shouldn't set the PagingController.value manually at the first page so
    /// that the controller can request the first page and show the loading
    /// indicator instead of the no elements found text.
    /// In the documentation bloc example, the screen widget subscribes to the
    /// bloc so the first time that subscribtion sets PagingController.value is
    /// when the PagingController makes the first page request which is
    /// different from the case here.
    ///
    /// Setting the PagingController.value here without the if condition would
    /// take place before rendering the PagedGridView which means before making
    /// the first page request by the controller, so this what made the error
    /// and no requests were made - however, I don't know in which way setting
    /// the PageController.value before PageController makes its first request
    /// ended up with making no requests at all.
    ///
    /// I found that using ref.listen() method here is better as the callback
    /// function passed to it doesn't get invoked till the first change occurs
    /// to the provider unlike watch() method which get the initial values of
    /// the provider.
    ///
    /// I will leave the code of the if condition and watch() method here to
    /// remember the best practice I found to use infinite_scroll_pagination
    /// package with riverpod. The first 2 paragraphs apply to the following
    /// if condition.

    // List<Character> characters = ref.watch(charactersProvider).characters;
    // int offset = ref.watch(charactersProvider).offset;
    // if (characters.isNotEmpty) {
    //   _pagingController.value = PagingState<int, Character>(
    //     nextPageKey: offset,
    //     itemList: characters,
    //   );
    // }

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
