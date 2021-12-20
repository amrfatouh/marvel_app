// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'characters_paginated_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CharactersPaginatedResponse _$CharactersPaginatedResponseFromJson(
    Map<String, dynamic> json) {
  return _CharactersPaginatedResponse.fromJson(json);
}

/// @nodoc
class _$CharactersPaginatedResponseTearOff {
  const _$CharactersPaginatedResponseTearOff();

  _CharactersPaginatedResponse call(
      {required int offset,
      required int limit,
      required int total,
      required int count,
      @JsonKey(name: 'results') required List<Character> characters}) {
    return _CharactersPaginatedResponse(
      offset: offset,
      limit: limit,
      total: total,
      count: count,
      characters: characters,
    );
  }

  CharactersPaginatedResponse fromJson(Map<String, Object?> json) {
    return CharactersPaginatedResponse.fromJson(json);
  }
}

/// @nodoc
const $CharactersPaginatedResponse = _$CharactersPaginatedResponseTearOff();

/// @nodoc
mixin _$CharactersPaginatedResponse {
  int get offset => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get count =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'results')
  List<Character> get characters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharactersPaginatedResponseCopyWith<CharactersPaginatedResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharactersPaginatedResponseCopyWith<$Res> {
  factory $CharactersPaginatedResponseCopyWith(
          CharactersPaginatedResponse value,
          $Res Function(CharactersPaginatedResponse) then) =
      _$CharactersPaginatedResponseCopyWithImpl<$Res>;
  $Res call(
      {int offset,
      int limit,
      int total,
      int count,
      @JsonKey(name: 'results') List<Character> characters});
}

/// @nodoc
class _$CharactersPaginatedResponseCopyWithImpl<$Res>
    implements $CharactersPaginatedResponseCopyWith<$Res> {
  _$CharactersPaginatedResponseCopyWithImpl(this._value, this._then);

  final CharactersPaginatedResponse _value;
  // ignore: unused_field
  final $Res Function(CharactersPaginatedResponse) _then;

  @override
  $Res call({
    Object? offset = freezed,
    Object? limit = freezed,
    Object? total = freezed,
    Object? count = freezed,
    Object? characters = freezed,
  }) {
    return _then(_value.copyWith(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      limit: limit == freezed
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      characters: characters == freezed
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<Character>,
    ));
  }
}

/// @nodoc
abstract class _$CharactersPaginatedResponseCopyWith<$Res>
    implements $CharactersPaginatedResponseCopyWith<$Res> {
  factory _$CharactersPaginatedResponseCopyWith(
          _CharactersPaginatedResponse value,
          $Res Function(_CharactersPaginatedResponse) then) =
      __$CharactersPaginatedResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {int offset,
      int limit,
      int total,
      int count,
      @JsonKey(name: 'results') List<Character> characters});
}

/// @nodoc
class __$CharactersPaginatedResponseCopyWithImpl<$Res>
    extends _$CharactersPaginatedResponseCopyWithImpl<$Res>
    implements _$CharactersPaginatedResponseCopyWith<$Res> {
  __$CharactersPaginatedResponseCopyWithImpl(
      _CharactersPaginatedResponse _value,
      $Res Function(_CharactersPaginatedResponse) _then)
      : super(_value, (v) => _then(v as _CharactersPaginatedResponse));

  @override
  _CharactersPaginatedResponse get _value =>
      super._value as _CharactersPaginatedResponse;

  @override
  $Res call({
    Object? offset = freezed,
    Object? limit = freezed,
    Object? total = freezed,
    Object? count = freezed,
    Object? characters = freezed,
  }) {
    return _then(_CharactersPaginatedResponse(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      limit: limit == freezed
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      characters: characters == freezed
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<Character>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CharactersPaginatedResponse implements _CharactersPaginatedResponse {
  const _$_CharactersPaginatedResponse(
      {required this.offset,
      required this.limit,
      required this.total,
      required this.count,
      @JsonKey(name: 'results') required this.characters});

  factory _$_CharactersPaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$$_CharactersPaginatedResponseFromJson(json);

  @override
  final int offset;
  @override
  final int limit;
  @override
  final int total;
  @override
  final int count;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'results')
  final List<Character> characters;

  @override
  String toString() {
    return 'CharactersPaginatedResponse(offset: $offset, limit: $limit, total: $total, count: $count, characters: $characters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CharactersPaginatedResponse &&
            const DeepCollectionEquality().equals(other.offset, offset) &&
            const DeepCollectionEquality().equals(other.limit, limit) &&
            const DeepCollectionEquality().equals(other.total, total) &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality()
                .equals(other.characters, characters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(offset),
      const DeepCollectionEquality().hash(limit),
      const DeepCollectionEquality().hash(total),
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(characters));

  @JsonKey(ignore: true)
  @override
  _$CharactersPaginatedResponseCopyWith<_CharactersPaginatedResponse>
      get copyWith => __$CharactersPaginatedResponseCopyWithImpl<
          _CharactersPaginatedResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharactersPaginatedResponseToJson(this);
  }
}

abstract class _CharactersPaginatedResponse
    implements CharactersPaginatedResponse {
  const factory _CharactersPaginatedResponse(
          {required int offset,
          required int limit,
          required int total,
          required int count,
          @JsonKey(name: 'results') required List<Character> characters}) =
      _$_CharactersPaginatedResponse;

  factory _CharactersPaginatedResponse.fromJson(Map<String, dynamic> json) =
      _$_CharactersPaginatedResponse.fromJson;

  @override
  int get offset;
  @override
  int get limit;
  @override
  int get total;
  @override
  int get count;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'results')
  List<Character> get characters;
  @override
  @JsonKey(ignore: true)
  _$CharactersPaginatedResponseCopyWith<_CharactersPaginatedResponse>
      get copyWith => throw _privateConstructorUsedError;
}
