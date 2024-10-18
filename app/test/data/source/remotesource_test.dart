import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/auth_model.dart';
import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/auth/data/models/userModel.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  test('Login Succeffully', ()async {
    //arrange
    final user=Usermodel(name: "Mouloud24", hashedPassword: "test123", pin: "", email: "devTest@gmail.com",  uid: "", payDay: DateTime(2024,10,02,20,50), totalBalance: Moneymodel(0, "DZD"), MonthlyIncome: Moneymodel(0, "DZD"));
    final expectedUser=AuthModel(user:user , accesToken: "", refreshToken: "");
    Remotedatasource remoteDataSource=Remotedatasource();
  final result=await remoteDataSource.login("devTest@gmail.com","test123");
    late final loggedUser;
  result.fold((f)=>f ,(r)=>loggedUser=r);
  expect(loggedUser,expectedUser );

    });
  test("Wrong Creditionals", ()async {
    //arrange
    Remotedatasource remoteDataSource=Remotedatasource();
    final result=await remoteDataSource.login("moloudgamer24@gmail.com", "test123");
   Failure expectedFailure=Failure("Email or Password Wrong");
    
   final errorMessage= result.fold((f)=>f ,(r)=>r);
   expect(errorMessage,expectedFailure);
    
  });
  test('Email or Password Not provided', () async{
    //arrange
    Remotedatasource remoteDataSource=Remotedatasource();
    final result=await remoteDataSource.login("", "test123");
   Failure expectedFailure=Failure("Provide Email and password");
    
   final errorMessage= result.fold((f)=>f ,(r)=>r);
   expect(errorMessage,expectedFailure);

    });
  test('Should return Email Already in use ', ()async {
   Remotedatasource remotedatasource=Remotedatasource();
    final expectedUser=Usermodel(name: "test_dart", hashedPassword:"test1234", pin: "", email: "mouloudgamer24@gmail.com", totalBalance: Moneymodel(0, "USD"),uid:"", payDay: DateTime(2024,10,02,18,50), MonthlyIncome: Moneymodel(0, "DZD")) ;
    final expectedResult=Failure("Email already in use");
    final result=await remotedatasource.signUp(expectedUser);
    late final signedUser;
    signedUser=result.fold((f)=>f ,(r)=>r);
    expect(signedUser, expectedResult);

  });
}
