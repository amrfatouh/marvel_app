import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/models/character/character.dart';
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
    int? total = ref.watch(charactersProvider).total;
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
                // refresh to empty characters list and caching map
                ref.read(charactersProvider).refresh();
              },
            ),
            SizedBox(height: 20),
            if (_searchTerm != null)
              Expanded(
                child: Center(
                  child: GridView.builder(
                    itemCount: total,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      Future<Character> characterFuture = ref.watch(
                          characterAtIndex(
                              PaginationOffset(_searchTerm!, index)));
                      return Center(
                          child: FutureBuilder(
                        future: characterFuture,
                        builder: (context, AsyncSnapshot<Character> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return CharacterTile(snapshot.data!);
                            } else if (snapshot.hasError) {
                              return Text('error: ${snapshot.error}');
                            }
                          }
                          return CircularProgressIndicator();
                        },
                      ));
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
