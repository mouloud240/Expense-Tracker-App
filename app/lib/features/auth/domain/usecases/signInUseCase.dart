import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

class Signinusecase {
  UserauthRepository repository;
  Signinusecase(this.repository);
  Future<Either<Failure,User>>call(User user)async{
    return await repository.SignUp(user);

  }
}
