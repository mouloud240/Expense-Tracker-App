import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/categories/domain/entities/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'categoryModel.freezed.dart';
@freezed
class Categorymodel with _$Categorymodel {
  const factory Categorymodel({
    required String id,
    required String name,
    required Moneymodel budget,
  }) = _Categorymodel;

  factory Categorymodel.fromJson(Map<String, dynamic> json) {
    return Categorymodel(
      id: json['Id'],
      name: json['Name'],
      budget: Moneymodel.fromjson(json['Budget']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Name": name,
      "Budget": budget.toJson(),
    };
  }  
 factory Categorymodel.fromEntity(Category category)=>
    Categorymodel(id: category.id, name: category.name, budget: Moneymodel.fromMoney(category.budget));

  Category toEntity() =>
    Category(
      id: id,
      name: name,
      budget: budget.toMoney(),
    );
}
