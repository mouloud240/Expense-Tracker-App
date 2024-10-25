
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
 factory User.placeHolder()=>User(MonthlyIncome: Money(0, 'USD'),totalBalance: Money(0, 'USD'),name: 'Diddy',hashedPassword: '',pin: '',email: '',uid: '',payDay: DateTime.now());  
}

