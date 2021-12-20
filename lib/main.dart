import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/models/character/character.dart';
import 'package:marvel_app/screens/all_characters_screen.dart';

enum LoadingState { loading, done }

void main() {
  runApp(ProviderScope(
    child: const MyApp(),
    // child: const MyPaginatedApp(),
  ));
}

final charactersProvider = ChangeNotifierProvider<CharacterListProvider>((ref) {
  return CharacterListProvider();
});

final charactersSearchProvider =
    ChangeNotifierProvider.autoDispose<CharacterListSearchProvider>((ref) {
  return CharacterListSearchProvider();
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: AllCharactersScreen(),
    );
  }
}
