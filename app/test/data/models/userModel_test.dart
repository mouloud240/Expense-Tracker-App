import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/auth/data/models/userModel.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("get UserModel from Json", (){
   //arrange 
   final json={"Name":"Mouloud","Password":"","Email":"dev@gmail.com","Jwt":"abcde","_id":"123456","PayDay":"2024-10-02T19:50:00","pin":"","totalBalance":{"Amount":0,"Currency":"DZD"},"monthlyIncome":{"Amount":0,"Currency":"DZD"}};
    final expectedUser=Usermodel(name: "Mouloud", hashedPassword: "tt", pin: "", email: "dev@gmail.com", jwt: "abcde", uid: "123456", payDay:DateTime(2024,10,02,19,50), totalBalance: Moneymodel(0,"DZD"), MonthlyIncome: Moneymodel(0,"DZD"));
    //act
    final returnedUser=Usermodel.fromJson(json);
    //expecet
    expect( returnedUser,expectedUser);
   });
  test('Return Json from Model',(){
    //arrange
    final user=Usermodel(name: "Mouloud", hashedPassword: "", pin: "", email: "dev@gmail.com", jwt: "abcde", uid: "123456", payDay:DateTime(2024,10,02,19,50), totalBalance: Moneymodel(0,"DZD"), MonthlyIncome: Money(0,"DZD"));

   final json={"Name":"Mouloud","Password":"","Email":"dev@gmail.com","Jwt":"abcde","_id":"123456","PayDay":"2024-10-02T19:50:00","pin":"","totalBalance":{"Amount":0,"Currency":"DZD"},"monthlyIncome":{"Amount":0,"Currency":"DZD"}};
    //act
    final returnedJson=user.toJson();
    //expecet
    expect( returnedJson,json);
  });
}
