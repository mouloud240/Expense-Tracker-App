import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

class Getbudgetusecase {
  final UserauthRepository  _repo;

  Getbudgetusecase(this._repo);
 Future<Either<Failure,Money>>call()async{
    return await _repo.getBudget();
  }

}
