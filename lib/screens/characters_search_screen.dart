import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/widgets/character_tile.dart';
import 'package:marvel_app/models/pagination_page.dart';
import 'package:marvel_app/models/pagination_offset.dart';

class CharactersSearchScreen extends ConsumerStatefulWidget {
  const CharactersSearchScreen({Key? key}) : super(key: key);

  @override
  _CharactersSearchScreenState createState() => _CharactersSearchScreenState();
}

class _CharactersSearchScreenState
    extends ConsumerState<CharactersSearchScreen> {
  String? _searchTerm;

  @override
  Widget build(BuildContext context) {
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
              },
            ),
            SizedBox(height: 20),
            if (_searchTerm != null)
              Expanded(
                  child: Center(
                child: ref
                    .watch(charactersCountProvider(
                        PaginationPage(_searchTerm!, 0)))
                    .when(
                      data: (count) => GridView.builder(
                        itemCount: count,
                        itemBuilder: (context, index) => Center(
                          child: ref
                              .watch(characterAtIndex(
                                  PaginationOffset(_searchTerm!, index)))
                              .when(
                                data: (character) => CharacterTile(character),
                                error: (error, _) => Text(error.toString()),
                                loading: () => CircularProgressIndicator(),
                              ),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                      ),
                      error: (err, stack) => Text('Error: $err'),
                      loading: () => CircularProgressIndicator(),
                    ),
              )),
          ],
        ),
      ),
    );
  }
}
