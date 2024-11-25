// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/userModel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  LocaledatasourceSECURE {
   FlutterSecureStorage Storage;
  LocaledatasourceSECURE(this.Storage);
 Future<Either<Failure,void>>setPin(String pin)async{
    try{

  Storage.write(key: "pin", value: pin); 
    }catch(e){
  return left(Failure("Error while setting pin"));
    }
    return right(null);
 }  
  Future<Either<Failure,void>>StoreTokens(String acccesToken,String refreshToken)async{
    // ignore: constant_identifier_names
    try { 
          await Storage.write(key: "acccesToken", value:acccesToken);
      await Storage.write(key: "refreshToken", value: refreshToken); 
        } catch (e) {
      return left(Failure("Error while storing Tokens"));
        }
    return right(null);
  }
  Future<Either<Failure,void>>StoreAccesToken(String accessToken)async{
    // ignore: constant_identifier_names
    try {
      await Storage.write(key: "acccesToken", value:accessToken);
    } catch (e) {
      print("this is the other one${e}");
      return left(Failure("Error while storing AccessToken"));
    }
    return right(null);
  }
  Future <Either<Failure,String>>getAccessToken()async{
    late String? acccesToken;
    try {
      acccesToken=await Storage.read(key: "acccesToken");
    } catch (e) {
      return left(Failure("Error while getting AccessToken"));
    }
    return right(acccesToken??"");
  }
  Future <Either<Failure,String>>getRefreshToken()async{
    late String? refreshToken;
    try {
      refreshToken=await Storage.read(key: "refreshToken");
    } catch (e) {
      return left(Failure("Error while getting RefreshToken"));
    }
    return right(refreshToken??"");
  }
  Future <Either<Failure,void>>ClearTokens()async{
    // ignore: constant_identifier_names
    try {
      await Storage.delete(key: "acccesToken");
      await Storage.delete(key: "refreshToken");
  
} catch (e) {
  return left(Failure("Error while clearing Tokens"));
    }
  return right(null);
  }
}
class Localdatasource {
 final SharedPreferences storage;

  Localdatasource(this.storage);
  Future<Either<Failure,void>>storeUser(Usermodel user)async{
    
    try {
      storage.setString("user", jsonEncode(user.toJson()));
        } catch (e) {
      return left(Failure("Error while storing User"));
        }
    return right(null);
  }
  Future <Either<Failure,Usermodel>>getUser()async{
    late Usermodel user;
    bool found=false;
    try {
      if (storage.containsKey("user")){
      final  String? json = storage.getString("user");
      if (json != null){
      found=true;
      }
      user=Usermodel.fromJson(jsonDecode(json!));
      }
    } catch (e) {
      print("the error is $e");
      return left(Failure("Error while getting User"));
    }
     if (!found){
     return left(Failure( "User not Found" ));
     }
    return right(user);
  }
  Future<bool> hasSeenWelcomePage()async{
    return storage.getBool("seenWelcomePage")??false;
  }
 }
