// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CharactersPaginatedResponse _$$_CharactersPaginatedResponseFromJson(
        Map<String, dynamic> json) =>
    _$_CharactersPaginatedResponse(
      offset: json['offset'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
      count: json['count'] as int,
      characters: (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CharactersPaginatedResponseToJson(
        _$_CharactersPaginatedResponse instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'limit': instance.limit,
      'total': instance.total,
      'count': instance.count,
      'results': instance.characters,
    };
