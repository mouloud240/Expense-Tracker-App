// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tokensModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokensModel _$TokensModelFromJson(Map<String, dynamic> json) {
  return _TokensModel.fromJson(json);
}

/// @nodoc
mixin _$TokensModel {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this TokensModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokensModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokensModelCopyWith<TokensModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokensModelCopyWith<$Res> {
  factory $TokensModelCopyWith(
          TokensModel value, $Res Function(TokensModel) then) =
      _$TokensModelCopyWithImpl<$Res, TokensModel>;
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$TokensModelCopyWithImpl<$Res, $Val extends TokensModel>
    implements $TokensModelCopyWith<$Res> {
  _$TokensModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokensModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokensModelImplCopyWith<$Res>
    implements $TokensModelCopyWith<$Res> {
  factory _$$TokensModelImplCopyWith(
          _$TokensModelImpl value, $Res Function(_$TokensModelImpl) then) =
      __$$TokensModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$$TokensModelImplCopyWithImpl<$Res>
    extends _$TokensModelCopyWithImpl<$Res, _$TokensModelImpl>
    implements _$$TokensModelImplCopyWith<$Res> {
  __$$TokensModelImplCopyWithImpl(
      _$TokensModelImpl _value, $Res Function(_$TokensModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokensModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_$TokensModelImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokensModelImpl implements _TokensModel {
  const _$TokensModelImpl(
      {required this.accessToken, required this.refreshToken});

  factory _$TokensModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokensModelImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'TokensModel(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokensModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  /// Create a copy of TokensModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokensModelImplCopyWith<_$TokensModelImpl> get copyWith =>
      __$$TokensModelImplCopyWithImpl<_$TokensModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokensModelImplToJson(
      this,
    );
  }
}

abstract class _TokensModel implements TokensModel {
  const factory _TokensModel(
      {required final String accessToken,
      required final String refreshToken}) = _$TokensModelImpl;

  factory _TokensModel.fromJson(Map<String, dynamic> json) =
      _$TokensModelImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;

  /// Create a copy of TokensModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokensModelImplCopyWith<_$TokensModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
