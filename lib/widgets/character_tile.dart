import 'package:flutter/material.dart';
import 'package:marvel_app/models/character/character.dart';
import 'package:marvel_app/screens/character_details_screen.dart';

class CharacterTile extends StatelessWidget {
  Character character;
  CharacterTile(this.character, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CharacterDetails(character))),
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
    );
  }
}
