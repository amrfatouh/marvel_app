import 'package:freezed_annotation/freezed_annotation.dart';

part 'marvel_api_keys.freezed.dart';
part 'marvel_api_keys.g.dart';

@freezed
class MarvelApiKeys with _$MarvelApiKeys {
  const factory MarvelApiKeys({
    required String publicKey,
    required String privateKey,
  }) = _MarvelApiKeys;

  factory MarvelApiKeys.fromJson(Map<String, Object?> json) =>
      _$MarvelApiKeysFromJson(json);
}
