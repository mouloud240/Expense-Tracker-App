import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

class Resetpasswordusecase {
  UserauthRepository repository;
  Resetpasswordusecase(this.repository);
  Future<Either<Failure,void>>call(String oldPassword,String newPassword)async{
    return await repository.resetpassword(oldPassword, newPassword);
  }
}
