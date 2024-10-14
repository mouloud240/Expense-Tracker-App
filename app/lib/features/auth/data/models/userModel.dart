// ignore_for_file: non_constant_identifier_names


import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class Usermodel extends User with EquatableMixin {
  Usermodel({required super.totalBalance,required super.name, required super.hashedPassword, required super.pin, required super.email, required super.jwt, required super.uid, required super.payDay, required super.MonthlyIncome});
 factory Usermodel.fromJson(Map<String,dynamic>Json){
    return Usermodel(name:Json['Name'] , hashedPassword: Json['Password'], pin :"", email: Json["Email"], jwt: Json['Jwt'], uid: Json['_id'], payDay: DateTime.parse(Json['PayDay']).toUtc() ,totalBalance:Moneymodel.fromjson(Json["totalBalance"]),MonthlyIncome: Moneymodel.fromjson(Json["monthlyIncome"]) );
  }
  Map<String,dynamic>  toJson(){
      return {
      "Password":hashedPassword,
      "Name":name,
      "Jwt":jwt,
      "pin":pin,
      "Email":email,
      "PayDay":payDay.toIso8601String().substring(0,payDay.toUtc().toIso8601String().length-5),
      "_id":uid,
      "totalBalance":Moneymodel(totalBalance.amount, totalBalance.currency).toJson(),
      "monthlyIncome":Moneymodel(MonthlyIncome.amount, MonthlyIncome.currency).toJson()
      };
    }
   factory Usermodel.fromUser(User user){
    return Usermodel(name: user.name, hashedPassword: user.hashedPassword, pin: user.pin, email: user.email, jwt: user.jwt, uid: user.uid, payDay: user.payDay, totalBalance: user.totalBalance, MonthlyIncome: user.MonthlyIncome);}
  
  @override

  List<Object?> get props => [name,email,totalBalance,payDay.toUtc(),MonthlyIncome];

}
