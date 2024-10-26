// ignore_for_file: non_constant_identifier_names

import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserauthRepository {
  Future<Either<Failure,User>> Login(String email,String password); 
 Future<bool>hasSeenWelcomePage();  
  Future <Either<Failure,User>>SignUp(User user);
  Future <Either<Failure,void>>resetpassword(String oldPassword,newPassword);
  Future<Either<Failure,User>>setPin(String pin);
  Future <Either<Failure,void>>forgotPassword(String Email,String newPassword);
  Future <Either<Failure,void>>logout();
}
