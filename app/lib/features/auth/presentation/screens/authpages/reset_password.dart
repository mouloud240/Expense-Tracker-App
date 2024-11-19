
import 'package:app/config/colors.dart';
import 'package:app/core/Services/sharedPrefsService.dart';
import 'package:app/features/auth/data/repository/userAuth_repository_impl.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:app/features/auth/domain/usecases/forgetPasswordUseCase.dart';
import 'package:app/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ResetPassword extends StatefulWidget {
  final String otp;
  final String email;
  const ResetPassword({super.key,required this.otp,required this.email});
    @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
     TextEditingController otpController=TextEditingController();

  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final _formkey = GlobalKey<FormState>();
    final RegExp passRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  late bool isPasswordVisible;
  late bool isConfirmPasswordVisible;
  @override
    void initState() {
      super.initState();
       passwordController=TextEditingController();
       confirmPasswordController=TextEditingController();
    
     isPasswordVisible=false;
    isConfirmPasswordVisible=false;

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
    Navigator.of(context).pushNamed('/login');
  }, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("ResetPassword" ,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24,color: Colors.black),),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox
        (
            height: 69,
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text("Enter the OTP sent to your email",style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.w700),),
          ),
          const SizedBox(height: 20,),
           Form(
            key: _formkey,
             child: Column(
               children: [
                 Field(hintText: "OTP",
                 validator: (value){
                   if (value!.isEmpty){
                     return "Please enter the OTP";
                   }
                   if (value!=widget.otp){
                     return "Invalid OTP";
                   }
                   return null;
                 },
                  isPasswordVisible: false, controller:otpController ),
               
  Field(controller: passwordController, hintText: "Password", validator: (value){
              if (value!.isEmpty){
                  return "Please enter your password"; 
              }
                  if (! passRegex.hasMatch(value)){
                  return "Password must contain at least 8 characters, one uppercase letter, one lowercase letter and one number";
                  }
return null;
                }
                ,isPasswordVisible:!isPasswordVisible, suffixIcon: isPasswordVisible?Icons.visibility:Icons.visibility_off, SuffixAction: (){
                  setState(() {
                    isPasswordVisible=!isPasswordVisible;
                  });
                }),
  Field(controller: confirmPasswordController, hintText: "Confirm Password", validator: (value){
              if (value!.isEmpty){
                  return "Please enter your password"; 
              }
                  if (value!=passwordController.text){
                  return "Passwords do not match";
                  }
                  
return null;
                }
                ,isPasswordVisible:!isConfirmPasswordVisible, suffixIcon: isConfirmPasswordVisible?Icons.visibility:Icons.visibility_off, SuffixAction: (){
                  setState(() {
                    isConfirmPasswordVisible=!isConfirmPasswordVisible;
                  });
                }),              
              ],
             ),
           )


          , 
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: ()async{
                   if (_formkey.currentState!.validate()){
                     //send the new password to the server
                  final response= await Forgetpasswordusecase(
                    UserauthRepositoryImpl(remotedatasource: Remotedatasource(), localedatasourceSECURE: LocaledatasourceSECURE(const FlutterSecureStorage()), localedatasource: Localdatasource(Sharedprefsservice().prefs))
                   ).call(widget.email, passwordController.text);
                   response.fold((l){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.message)));
                   }, (r){
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password reset successfully")));
                                       });}},
                style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),),                
                backgroundColor: WidgetStateProperty.all(Appcolors.violet100),
                minimumSize: WidgetStateProperty.all( Size(343.w, 56.h)),
                )
                , 
                child: Text("Reset Password",style: TextStyle(fontSize: 24.sp,color: Colors.white),),
              ),
            ),
          ),
        ],
      )
    ); 
  }
}
