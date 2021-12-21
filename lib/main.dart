import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/marvel_repository.dart';
import 'package:marvel_app/models/character/character.dart';
import 'package:marvel_app/models/pagination_page.dart';
import 'package:marvel_app/models/pagination_offset.dart';
import 'package:marvel_app/models/characters_paginated_response/characters_paginated_response.dart';
import 'package:marvel_app/screens/all_characters_screen.dart';

enum LoadingState { loading, done }

void main() {
  runApp(ProviderScope(
    child: const MyApp(),
  ));
}

final charactersResponseProvider =
    FutureProvider.family<CharactersPaginatedResponse, PaginationPage>(
        (ref, pagination) async {
  return MarvelRepository().fetchCharacters(
    limit: 100,
    offset: pagination.page * 100,
    nameStartsWith: pagination.name,
  );
});

final charactersProvider =
    Provider.family<AsyncValue<List<Character>>, PaginationPage>(
        (ref, paginationPage) => ref
            .watch(charactersResponseProvider(paginationPage))
            .whenData((response) => response.characters));

final charactersCountProvider =
    Provider.family<AsyncValue<int>, PaginationPage>((ref, paginationPage) =>
        ref
            .watch(charactersResponseProvider(paginationPage))
            .whenData((response) => response.total));

final characterAtIndex = Provider.autoDispose
    .family<AsyncValue<Character>, PaginationOffset>((ref, offset) {
  int page = (offset.index / 100).floor();
  int indexInPage = offset.index % 100;
  return ref
      .watch(charactersProvider(PaginationPage(offset.name, page)))
      .whenData((List<Character> characters) => characters[indexInPage]);
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
