// ignore_for_file: non_constant_identifier_names


import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';


class Usermodel extends User with EquatableMixin {
  Usermodel({
    required super.name,
    required super.hashedPassword,
    required super.pin,
    required super.email,
    required super.uid,
    required DateTime payDay,
    required Moneymodel totalBalance,
    required Moneymodel MonthlyIncome,
  }) : super(
          payDay: payDay.toUtc(), // Ensure it's in UTC
          totalBalance: Moneymodel.fromMoney(totalBalance),
          MonthlyIncome: Moneymodel.fromMoney(MonthlyIncome),
        );

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    print("Json is $json");
    return Usermodel(
      name: json['Name'],
      hashedPassword: json['Password'],
      pin: json['pin'],
      email: json["Email"],
      uid: json['_id'],
      payDay: DateTime.parse(json['PayDay']).toUtc(), // Ensure it's in UTC
      totalBalance: Moneymodel.fromjson(json["totalBalance"]),
      MonthlyIncome: Moneymodel.fromjson(json["monthlyIncome"]),
    );
  }
  
  factory Usermodel.fromEntity(User user) {
    return Usermodel(
      name: user.name,
      hashedPassword: user.hashedPassword,
      pin: user.pin,
      email: user.email,
      uid: user.uid,
      payDay: user.payDay,
      totalBalance: Moneymodel.fromMoney(user.totalBalance) ,
      MonthlyIncome:Moneymodel.fromMoney(user.MonthlyIncome) ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Password": hashedPassword,
      "Name": name,
      "pin": pin,
      "Email": email,
      "PayDay": payDay.toIso8601String(), // No need to alter, keep ISO format
      "_id": uid,
      "totalBalance" :Moneymodel.fromMoney(totalBalance).toJson(),
      "monthlyIncome": Moneymodel.fromMoney(MonthlyIncome).toJson()
    };
  }

  @override
  List<Object?> get props => [name, email, totalBalance, payDay.toUtc(), MonthlyIncome];
}

