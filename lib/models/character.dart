import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/marvel_repository.dart';
import 'package:marvel_app/models/thumbnail.dart';
import 'package:riverpod/riverpod.dart';

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
}