
import 'package:app/features/auth/domain/entities/subEntities/money.dart';

class User {
 String name;
 String email;
 String jwt;
 String uid;
 String pin;
 String hashedPassword; 
Money totalBalance;
  Money MonthlyIncome;
 DateTime payDay;
 User({required this.MonthlyIncome,required this.totalBalance,required this.name,required this.hashedPassword,required this.pin,required this.email,required this.jwt,required this.uid,required this.payDay});
  
}

