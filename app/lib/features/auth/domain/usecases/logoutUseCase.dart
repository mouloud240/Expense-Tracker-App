import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

class Logoutusecase {
  UserauthRepository repository;
  Logoutusecase(this.repository);
  Future<Either<Failure,void>> call()async{
    return await repository.logout();
  }
}
