// ignore_for_file: non_constant_identifier_names

import 'package:app/features/auth/data/models/userModel.dart';
import 'package:equatable/equatable.dart';

class AuthModel extends Equatable{
 Usermodel user;
 String accesToken;
  String refreshToken;
  AuthModel({required this.user,required this.accesToken,required this.refreshToken});
  factory AuthModel.fromJson(Map<String,dynamic>Json){
    return AuthModel(user: Usermodel.fromJson(Json["user"]),accesToken: Json["accesToken"],refreshToken: Json["refreshToken"]);
  }
  Map<String,dynamic>  toJson(){
      return {
      "user":user.toJson(),
      "accesToken":accesToken,
      "refreshToken":refreshToken
      };
    }
  
  @override
  List<Object?> get props => [user];
}

