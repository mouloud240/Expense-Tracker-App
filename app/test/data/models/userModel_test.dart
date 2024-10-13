import 'package:app/features/auth/data/models/userModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("get UserModel from Json", (){
   //arrange 
   final json={"Name":"Mouloud","Password":"","Email":"dev@gmail.com","Jwt":"abcde","_id":"123456","PayDay":"024-10-02T19:50:00"};
    final expectedUser=Usermodel(name: "Mouloud", hashedPassword: "tt", pin: "", email: "dev@gmail.com", jwt: "abcde", uid: "123456", payDay:DateTime(2024,10,02,19,50));
    //act
    final returnedUser=Usermodel.fromJson(json);
    //expecet
    expect(expectedUser, returnedUser);
   });
  test('Return Json from Model',(){
    //arrange
    final user=Usermodel(name: "Mouloud", hashedPassword: "", pin: "", email: "dev@gmail.com", jwt: "abcde", uid: "123456", payDay:DateTime(2024,10,02,19,50));

   final json={"Name":"Mouloud","Password":"","Email":"dev@gmail.com","Jwt":"abcde","_id":"123456","PayDay":"2024-10-02T19:50:00","pin":""};
    //act
    final returnedJson=user.toJson();
    //expecet
    expect( returnedJson,json);
  });
}
