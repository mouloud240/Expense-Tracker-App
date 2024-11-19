// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categoryModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Categorymodel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Moneymodel get budget => throw _privateConstructorUsedError;

  /// Create a copy of Categorymodel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategorymodelCopyWith<Categorymodel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorymodelCopyWith<$Res> {
  factory $CategorymodelCopyWith(
          Categorymodel value, $Res Function(Categorymodel) then) =
      _$CategorymodelCopyWithImpl<$Res, Categorymodel>;
  @useResult
  $Res call({String id, String name, Moneymodel budget});
}

/// @nodoc
class _$CategorymodelCopyWithImpl<$Res, $Val extends Categorymodel>
    implements $CategorymodelCopyWith<$Res> {
  _$CategorymodelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Categorymodel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? budget = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Moneymodel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategorymodelImplCopyWith<$Res>
    implements $CategorymodelCopyWith<$Res> {
  factory _$$CategorymodelImplCopyWith(
          _$CategorymodelImpl value, $Res Function(_$CategorymodelImpl) then) =
      __$$CategorymodelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, Moneymodel budget});
}

/// @nodoc
class __$$CategorymodelImplCopyWithImpl<$Res>
    extends _$CategorymodelCopyWithImpl<$Res, _$CategorymodelImpl>
    implements _$$CategorymodelImplCopyWith<$Res> {
  __$$CategorymodelImplCopyWithImpl(
      _$CategorymodelImpl _value, $Res Function(_$CategorymodelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Categorymodel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? budget = null,
  }) {
    return _then(_$CategorymodelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Moneymodel,
    ));
  }
}

/// @nodoc

class _$CategorymodelImpl implements _Categorymodel {
  const _$CategorymodelImpl(
      {required this.id, required this.name, required this.budget});

  @override
  final String id;
  @override
  final String name;
  @override
  final Moneymodel budget;

  @override
  String toString() {
    return 'Categorymodel(id: $id, name: $name, budget: $budget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorymodelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.budget, budget) || other.budget == budget));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, budget);

  /// Create a copy of Categorymodel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorymodelImplCopyWith<_$CategorymodelImpl> get copyWith =>
      __$$CategorymodelImplCopyWithImpl<_$CategorymodelImpl>(this, _$identity);

  @override

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      budget: budget.toMoney(),
    );
  }


  @override
  Map<String, dynamic> toJson() {
   return {
      "Id": id,
      "Name": name,
      "Budget": budget.toJson(),
    }; 
  }

}

abstract class _Categorymodel implements Categorymodel {
  const factory _Categorymodel(
      {required final String id,
      required final String name,
      required final Moneymodel budget}) = _$CategorymodelImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  Moneymodel get budget;

  /// Create a copy of Categorymodel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategorymodelImplCopyWith<_$CategorymodelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
