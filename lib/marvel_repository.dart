import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:marvel_app/models/character.dart';
import 'package:marvel_app/models/characters_paginated_response.dart';
import 'package:marvel_app/models/marvel_api_keys.dart';
import 'package:marvel_app/server_exception.dart';

class MarvelRepository {
  final Dio _dio;

  MarvelRepository([Dio? dio]) : _dio = dio ?? Dio();

  Future<CharactersPaginatedResponse> fetchCharacters({
    int offset = 0,
    int limit = 50,
  }) async {
    String keysJson =
        await rootBundle.loadString('assets/marvel_api_keys.json');
    MarvelApiKeys marvelApiKeys = MarvelApiKeys.fromJson(jsonDecode(keysJson));
    int ts = DateTime.now().millisecondsSinceEpoch;
    String hash = md5
        .convert(utf8
            .encode('$ts${marvelApiKeys.privateKey}${marvelApiKeys.publicKey}'))
        .toString();
    try {
      final response = await _dio.get(
        'https://gateway.marvel.com:443/v1/public/characters',
        queryParameters: {
          'apikey': marvelApiKeys.publicKey,
          'ts': ts,
          'hash': hash,
          'offset': offset,
          'limit': limit,
        },
      );
      Map<String, dynamic> jsonData = response.data['data'];
      return CharactersPaginatedResponse.fromJson(jsonData);
    } catch (e) {
      throw ServerException('Couldn\'t fetch characters');
    }
  }
}
