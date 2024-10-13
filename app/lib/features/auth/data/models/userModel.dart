// ignore_for_file: non_constant_identifier_names


import 'package:app/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class Usermodel extends User with EquatableMixin {
  Usermodel({required super.name, required super.hashedPassword, required super.pin, required super.email, required super.jwt, required super.uid, required super.payDay});
 factory Usermodel.fromJson(Map<String,dynamic>Json){
    return Usermodel(name:Json['Name'] , hashedPassword: Json['Password'], pin :"", email: Json["Email"], jwt: Json['Jwt'], uid: Json['_id'], payDay: DateTime.parse("2024-10-02T19:50:00.000+00:00") );
  }
  Map<String,dynamic>  toJson(){
      return {
      "Password":hashedPassword,
      "Name":name,
      "Jwt":jwt,
      "pin":pin,
      "Email":email,
      "PayDay":payDay.toIso8601String().substring(0,payDay.toUtc().toIso8601String().length-5),
      "_id":uid
      };
    }
  
  @override
  List<Object?> get props => [name,email,uid,jwt];

}
