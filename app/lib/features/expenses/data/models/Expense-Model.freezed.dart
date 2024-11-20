// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Expense-Model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExpenseModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Categorymodel get category => throw _privateConstructorUsedError;
  Moneymodel get amount => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseModelCopyWith<ExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseModelCopyWith<$Res> {
  factory $ExpenseModelCopyWith(
          ExpenseModel value, $Res Function(ExpenseModel) then) =
      _$ExpenseModelCopyWithImpl<$Res, ExpenseModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      Categorymodel category,
      Moneymodel amount,
      DateTime date});

  $CategorymodelCopyWith<$Res> get category;
}

/// @nodoc
class _$ExpenseModelCopyWithImpl<$Res, $Val extends ExpenseModel>
    implements $ExpenseModelCopyWith<$Res> {
  _$ExpenseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? amount = null,
    Object? date = null,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Categorymodel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Moneymodel,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategorymodelCopyWith<$Res> get category {
    return $CategorymodelCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExpenseModelImplCopyWith<$Res>
    implements $ExpenseModelCopyWith<$Res> {
  factory _$$ExpenseModelImplCopyWith(
          _$ExpenseModelImpl value, $Res Function(_$ExpenseModelImpl) then) =
      __$$ExpenseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      Categorymodel category,
      Moneymodel amount,
      DateTime date});

  @override
  $CategorymodelCopyWith<$Res> get category;
}

/// @nodoc
class __$$ExpenseModelImplCopyWithImpl<$Res>
    extends _$ExpenseModelCopyWithImpl<$Res, _$ExpenseModelImpl>
    implements _$$ExpenseModelImplCopyWith<$Res> {
  __$$ExpenseModelImplCopyWithImpl(
      _$ExpenseModelImpl _value, $Res Function(_$ExpenseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? amount = null,
    Object? date = null,
  }) {
    return _then(_$ExpenseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Categorymodel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Moneymodel,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$ExpenseModelImpl implements _ExpenseModel {
  const _$ExpenseModelImpl(
      {required this.id,
      required this.name,
      required this.category,
      required this.amount,
      required this.date});

  @override
  final String id;
  @override
  final String name;
  @override
  final Categorymodel category;
  @override
  final Moneymodel amount;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'ExpenseModel(id: $id, name: $name, category: $category, amount: $amount, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, category, amount, date);

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseModelImplCopyWith<_$ExpenseModelImpl> get copyWith =>
      __$$ExpenseModelImplCopyWithImpl<_$ExpenseModelImpl>(this, _$identity);

  @override
  Expense toEntity() {
   return Expense(
       id: id,
       name: name,
       category: category.toEntity(),
       amount: amount.toMoney(),
       date: date,
     );
  }

  @override
  Map<String, dynamic> toJson() {
   return {
       "Id": id,
       "Name": name,
       "Category": category,
       "Amount": amount.toJson(),
       "Date": date.toIso8601String(),
     };
  }
}

abstract class _ExpenseModel implements ExpenseModel {
  const factory _ExpenseModel(
      {required final String id,
      required final String name,
      required final Categorymodel category,
      required final Moneymodel amount,
      required final DateTime date}) = _$ExpenseModelImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  Categorymodel get category;
  @override
  Moneymodel get amount;
  @override
  DateTime get date;

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseModelImplCopyWith<_$ExpenseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
