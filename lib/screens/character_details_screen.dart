import 'package:flutter/material.dart';
import 'package:marvel_app/models/character/character.dart';

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
