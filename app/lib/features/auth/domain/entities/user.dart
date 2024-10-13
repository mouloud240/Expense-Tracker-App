
class User {
 String name;
 String email;
 String jwt;
 String uid;
 String pin;
 String hashedPassword; 
 DateTime payDay;
 User({required this.name,required this.hashedPassword,required this.pin,required this.email,required this.jwt,required this.uid,required this.payDay});
  
}

