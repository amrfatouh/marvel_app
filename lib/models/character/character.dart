import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/marvel_repository.dart';
import 'package:marvel_app/models/characters_paginated_response/characters_paginated_response.dart';
import 'package:marvel_app/models/pagination_offset.dart';
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
  final Map<int, Future<CharactersPaginatedResponse>> _fetchedPages = {};

  Future<CharactersPaginatedResponse> fetchCharacters(
      PaginationOffset paginationOffset,
      {bool doesNotify = false}) async {
    int page = (paginationOffset.index / 100).floor();
    if (_fetchedPages.keys.contains(page)) {
      return _fetchedPages[page] as Future<CharactersPaginatedResponse>;
    }

    loadingState = LoadingState.loading;
    if (doesNotify) notifyListeners();

    try {
      _fetchedPages[page] = _marvelRepository.fetchCharacters(
          offset: offset, limit: limit, nameStartsWith: paginationOffset.name);
      final paginatedRes =
          await _fetchedPages[page] as CharactersPaginatedResponse;
      characters = [...characters, ...paginatedRes.characters];
      total = paginatedRes.total;
      count = paginatedRes.count;
      offset += count!;
      hasNext = offset < total!;
      return paginatedRes;
    } finally {
      print('entered finally section');
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
    _fetchedPages.clear();
    if (doesNotify) notifyListeners();
  }

  @override
  String toString() {
    return 'CharacterListProvider (offset: $offset, limit: $limit, hasNext: $hasNext, total: $total, count: $count, loadingState: $loadingState, characters: $characters';
  }
}
