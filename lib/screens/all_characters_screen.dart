import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/models/character/character.dart';
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
    int? total = ref.watch(charactersProvider).total;
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel App'),
        actions: [
          IconButton(
              onPressed: () {
                // refresh to empty characters list and caching map
                ref.read(charactersProvider).refresh();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CharactersSearchScreen()));
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: Center(
        child: GridView.builder(
          itemCount: total,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            Future<Character> characterFuture =
                ref.watch(characterAtIndex(PaginationOffset('', index)));
            return Center(
                child: FutureBuilder(
              future: characterFuture,
              builder: (context, AsyncSnapshot<Character> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
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
    );
  }
}
