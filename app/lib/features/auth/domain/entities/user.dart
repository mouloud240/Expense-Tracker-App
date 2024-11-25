
import 'package:app/features/auth/domain/entities/subEntities/money.dart';

class User {
 String name;
 String email;
 String uid;
 String pin;
 String hashedPassword; 
Money totalBalance;
// ignore: non_constant_identifier_names
Money MonthlyIncome;
 DateTime payDay;
 User({required this.MonthlyIncome,required this.totalBalance,required this.name,required this.hashedPassword,required this.pin,required this.email,required this.uid,required this.payDay});
 // ignore: non_constant_identifier_names
 User copyWith({Money? MonthlyIncome,Money? totalBalance,String? name,String? hashedPassword,String? pin,String? email,String? uid,DateTime? payDay}){
   return User(MonthlyIncome: MonthlyIncome??this.MonthlyIncome, totalBalance: totalBalance??this.totalBalance, name: name??this.name, hashedPassword: hashedPassword??this.hashedPassword, pin: pin??this.pin, email: email??this.email, uid: uid??this.uid, payDay: payDay??this.payDay);
 }
}

