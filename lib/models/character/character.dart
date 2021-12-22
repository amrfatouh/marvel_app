import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/marvel_repository.dart';
import 'package:marvel_app/models/thumbnail/thumbnail.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required int id,
    required String name,
    required String description,
    required Thumbnail thumbnail,
  }) = _Character;

  factory Character.fromJson(Map<String, Object?> json) =>
      _$CharacterFromJson(json);
}

class CharacterListProvider extends ChangeNotifier {
  final MarvelRepository _marvelRepository = MarvelRepository();
  List<Character> characters = [];
  int offset = 0;
  final int limit = 100;
  bool hasNext = true;
  int? total;
  int? count;
  LoadingState loadingState = LoadingState.done;

  Future<void> fetchCharacters({bool doesNotify = true}) async {
    loadingState = LoadingState.loading;
    if (doesNotify) notifyListeners();

    try {
      final paginatedRes =
          await _marvelRepository.fetchCharacters(offset: offset, limit: limit);
      characters = [...characters, ...paginatedRes.characters];
      total = paginatedRes.total;
      count = paginatedRes.count;
      offset += count!;
      hasNext = offset < total!;
    } finally {
      loadingState = LoadingState.done;
      notifyListeners();
    }
  }

  @override
  String toString() {
    return 'CharacterListProvider (offset: $offset, limit: $limit, hasNext: $hasNext, total: $total, count: $count, loadingState: $loadingState, characters: $characters';
  }
}

class CharacterListSearchProvider extends ChangeNotifier {
  final MarvelRepository _marvelRepository = MarvelRepository();
  List<Character> characters = [];
  int offset = 0;
  final int limit = 100;
  bool hasNext = true;
  int? total;
  int? count;
  LoadingState loadingState = LoadingState.done;

  Future<void> fetchCharacters(String nameStartsWith,
      {bool doesNotify = true}) async {
    loadingState = LoadingState.loading;
    if (doesNotify) notifyListeners();

    try {
      final paginatedRes = await _marvelRepository.fetchCharacters(
          offset: offset, limit: limit, nameStartsWith: nameStartsWith);
      characters = [...characters, ...paginatedRes.characters];
      total = paginatedRes.total;
      count = paginatedRes.count;
      offset += count!;
      hasNext = offset < total!;
    } finally {
      loadingState = LoadingState.done;
      notifyListeners();
    }
  }

  void refresh({bool doesNotify = false}) {
    characters = [];
    offset = 0;
    hasNext = true;
    total = null;
    count = null;
    loadingState = LoadingState.done;
    if (doesNotify) notifyListeners();
  }
}
