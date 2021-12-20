import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'thumbnail.g.dart';
part 'thumbnail.freezed.dart';

@freezed
class Thumbnail with _$Thumbnail {
  const factory Thumbnail({
    required String path,
    required String extension,
  }) = _Thumbnail;

  const Thumbnail._();

  factory Thumbnail.fromJson(Map<String, Object?> json) =>
      _$ThumbnailFromJson(json);

  String get url => '$path.$extension';

  BoxFit get boxFit =>
      path != 'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available'
          ? BoxFit.cover
          : BoxFit.fill;
}
