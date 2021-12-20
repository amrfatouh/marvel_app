import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marvel_app/models/character.dart';

part 'characters_paginated_response.freezed.dart';
part 'characters_paginated_response.g.dart';

@freezed
class CharactersPaginatedResponse with _$CharactersPaginatedResponse {
  const factory CharactersPaginatedResponse({
    required int offset,
    required int limit,
    required int total,
    required int count,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'results') required List<Character> characters,
  }) = _CharactersPaginatedResponse;

  factory CharactersPaginatedResponse.fromJson(Map<String, Object?> json) =>
      _$CharactersPaginatedResponseFromJson(json);
}
