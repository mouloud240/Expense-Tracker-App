import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:equatable/equatable.dart';

class Moneymodel extends Money with EquatableMixin {
  Moneymodel(super.amount, super.currency, {required int amount});
   factory Moneymodel.fromjson(Map<String,dynamic>json){
    return Moneymodel( json['Amount'].toDouble(), json['Currency']);}
  Map<String,dynamic> toJson(){
    return {
      "Amount":amount,
      "Currency":currency
    };
  }
  factory Moneymodel.fromMoney(Money money){
    return Moneymodel(money.amount, money.currency);
  }

  @override
  List<Object?> get props => [amount,currency];

 Money  toMoney()=>
  Money(amount, currency);
}
