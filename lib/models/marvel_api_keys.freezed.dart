// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'marvel_api_keys.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MarvelApiKeys _$MarvelApiKeysFromJson(Map<String, dynamic> json) {
  return _MarvelApiKeys.fromJson(json);
}

/// @nodoc
class _$MarvelApiKeysTearOff {
  const _$MarvelApiKeysTearOff();

  _MarvelApiKeys call({required String publicKey, required String privateKey}) {
    return _MarvelApiKeys(
      publicKey: publicKey,
      privateKey: privateKey,
    );
  }

  MarvelApiKeys fromJson(Map<String, Object?> json) {
    return MarvelApiKeys.fromJson(json);
  }
}

/// @nodoc
const $MarvelApiKeys = _$MarvelApiKeysTearOff();

/// @nodoc
mixin _$MarvelApiKeys {
  String get publicKey => throw _privateConstructorUsedError;
  String get privateKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MarvelApiKeysCopyWith<MarvelApiKeys> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarvelApiKeysCopyWith<$Res> {
  factory $MarvelApiKeysCopyWith(
          MarvelApiKeys value, $Res Function(MarvelApiKeys) then) =
      _$MarvelApiKeysCopyWithImpl<$Res>;
  $Res call({String publicKey, String privateKey});
}

/// @nodoc
class _$MarvelApiKeysCopyWithImpl<$Res>
    implements $MarvelApiKeysCopyWith<$Res> {
  _$MarvelApiKeysCopyWithImpl(this._value, this._then);

  final MarvelApiKeys _value;
  // ignore: unused_field
  final $Res Function(MarvelApiKeys) _then;

  @override
  $Res call({
    Object? publicKey = freezed,
    Object? privateKey = freezed,
  }) {
    return _then(_value.copyWith(
      publicKey: publicKey == freezed
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      privateKey: privateKey == freezed
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MarvelApiKeysCopyWith<$Res>
    implements $MarvelApiKeysCopyWith<$Res> {
  factory _$MarvelApiKeysCopyWith(
          _MarvelApiKeys value, $Res Function(_MarvelApiKeys) then) =
      __$MarvelApiKeysCopyWithImpl<$Res>;
  @override
  $Res call({String publicKey, String privateKey});
}

/// @nodoc
class __$MarvelApiKeysCopyWithImpl<$Res>
    extends _$MarvelApiKeysCopyWithImpl<$Res>
    implements _$MarvelApiKeysCopyWith<$Res> {
  __$MarvelApiKeysCopyWithImpl(
      _MarvelApiKeys _value, $Res Function(_MarvelApiKeys) _then)
      : super(_value, (v) => _then(v as _MarvelApiKeys));

  @override
  _MarvelApiKeys get _value => super._value as _MarvelApiKeys;

  @override
  $Res call({
    Object? publicKey = freezed,
    Object? privateKey = freezed,
  }) {
    return _then(_MarvelApiKeys(
      publicKey: publicKey == freezed
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      privateKey: privateKey == freezed
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MarvelApiKeys implements _MarvelApiKeys {
  const _$_MarvelApiKeys({required this.publicKey, required this.privateKey});

  factory _$_MarvelApiKeys.fromJson(Map<String, dynamic> json) =>
      _$$_MarvelApiKeysFromJson(json);

  @override
  final String publicKey;
  @override
  final String privateKey;

  @override
  String toString() {
    return 'MarvelApiKeys(publicKey: $publicKey, privateKey: $privateKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MarvelApiKeys &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            const DeepCollectionEquality()
                .equals(other.privateKey, privateKey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(publicKey),
      const DeepCollectionEquality().hash(privateKey));

  @JsonKey(ignore: true)
  @override
  _$MarvelApiKeysCopyWith<_MarvelApiKeys> get copyWith =>
      __$MarvelApiKeysCopyWithImpl<_MarvelApiKeys>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MarvelApiKeysToJson(this);
  }
}

abstract class _MarvelApiKeys implements MarvelApiKeys {
  const factory _MarvelApiKeys(
      {required String publicKey,
      required String privateKey}) = _$_MarvelApiKeys;

  factory _MarvelApiKeys.fromJson(Map<String, dynamic> json) =
      _$_MarvelApiKeys.fromJson;

  @override
  String get publicKey;
  @override
  String get privateKey;
  @override
  @JsonKey(ignore: true)
  _$MarvelApiKeysCopyWith<_MarvelApiKeys> get copyWith =>
      throw _privateConstructorUsedError;
}
