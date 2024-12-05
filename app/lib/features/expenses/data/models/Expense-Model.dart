
import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/expenses/data/models/subModels/categoryModel.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'Expense-Model.freezed.dart';
@freezed
class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    required String id,
    required String name ,
    required Categorymodel category,
    required Moneymodel amount,
    required DateTime date,
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['_id']??"",
      name: json['Name']??"dummy",
      category:json['Category']!=null? Categorymodel.fromJson(json['Category']):Categorymodel(id: "", name: "", budget: Moneymodel(0, "")),
      amount: json['Amount']!=null?Moneymodel.fromjson(json['Amount']):Moneymodel(0, ""),
      date:json['Date']!=null ?DateTime.parse(json['Date']):DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Name": name,
      "category": category,
      "Amount": amount.toJson(),
      "Date": date.toIso8601String(),
    };
  }
  factory ExpenseModel.fromEntity(Expense expense)=>
   ExpenseModel(id: expense.id, name: expense.name, category:Categorymodel.fromEntity(expense.category), amount:Moneymodel.fromMoney(expense.amount) , date: expense.date);
  Expense toEntity()=>
  Expense(
      id: id,
      name: name,
      category: category.toEntity(),
      amount: amount.toMoney(),
      date: date,
    );
  }


