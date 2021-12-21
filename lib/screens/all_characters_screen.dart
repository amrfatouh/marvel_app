import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/screens/characters_search_screen.dart';
import 'package:marvel_app/widgets/character_tile.dart';
import 'package:marvel_app/models/pagination_page.dart';
import 'package:marvel_app/models/pagination_offset.dart';

class AllCharactersScreen extends ConsumerStatefulWidget {
  const AllCharactersScreen({Key? key}) : super(key: key);

  @override
  _AllCharactersScreenState createState() => _AllCharactersScreenState();
}

class _AllCharactersScreenState extends ConsumerState<AllCharactersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel App'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CharactersSearchScreen())),
              icon: Icon(Icons.search)),
        ],
      ),
      body: Center(
        child: ref.watch(charactersCountProvider(PaginationPage('', 0))).when(
              data: (count) => GridView.builder(
                itemCount: count,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Center(
                  child: ref
                      .watch(characterAtIndex(PaginationOffset('', index)))
                      .when(
                        data: (character) => CharacterTile(character),
                        error: (error, _) => Text(error.toString()),
                        loading: () => CircularProgressIndicator(),
                      ),
                ),
              ),
              error: (err, stack) => Text('Error: $err'),
              loading: () => CircularProgressIndicator(),
            ),
      ),
    );
  }
}
