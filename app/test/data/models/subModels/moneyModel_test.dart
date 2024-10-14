import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
   test('Get MoneyModel From json', () {
     
      final moneyModel=Moneymodel(100, "DZD");
      final moneyModelFromJson=Moneymodel.fromjson({"Amount":100,"Currency":"DZD"});    
      expect(moneyModel, moneyModelFromJson);
      });
  test('Return Json from MoneyModel', () {
    final moneyModel=Moneymodel(100, "DZD");
    final moneyModelToJson=moneyModel.toJson();
    final expectedJson={"Amount":100,"Currency":"DZD"};
    expect(moneyModelToJson, expectedJson);
  });
}
