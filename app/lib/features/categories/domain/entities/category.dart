import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "category.freezed.dart";
@freezed
class Category with _$Category {
  const factory Category({
    required String name,
    required Money budget,
  }) = _Category;
  }
