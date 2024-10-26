import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

class Setpinusecase {
  UserauthRepository repository;
  Setpinusecase(this.repository);
Future <Either<Failure,User>>call(String pin)async{
    return await repository.setPin(pin);
  }
}
