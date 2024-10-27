
import 'package:app/config/colors.dart';
import 'package:app/core/Services/sharedPrefsService.dart';
import 'package:app/features/auth/data/repository/userAuth_repository_impl.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:app/features/auth/domain/usecases/sendPassResetEmailUseCase.dart';
import 'package:app/features/auth/presentation/screens/authpages/reset_password.dart';
import 'package:app/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    String otp="";
    final RegExp mailRegex = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"  
    );
    final _formkey = GlobalKey<FormState>();
    const text="Don’t worry. \n Enter your email and we’ll send you a link to reset your password.";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("ForgotPassword" ,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24.sp,color: Appcolors.dark75),),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox
        (
            height: 69.h,
          ),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Text(text,style: TextStyle(fontSize: 24.sp,color: Appcolors.dark75,fontWeight: FontWeight.w700),),
          ),
          SizedBox(height: 20.h,),
          Form(
          key: _formkey,
            child:Field(controller: emailController, regexp: mailRegex, hintText: "Email", validator:(value){
              if (value!.isEmpty){
                return "Please enter your email";
              }
              if (!mailRegex.hasMatch(value)){
                return "Please enter a valid email";
              }

              return null;
            },
 )            ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: ()async{
                if (_formkey.currentState!.validate()){
                 final response=await Sendpassresetemailusecase(
                 UserauthRepositoryImpl(remotedatasource: Remotedatasource(), localedatasourceSECURE:LocaledatasourceSECURE(FlutterSecureStorage()), localedatasource:Localdatasource(Sharedprefsservice().prefs))
                 ).call(emailController.text);   
                
  response.fold((l){
 return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.message)));
  }, (r){ 
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ResetPassword(otp: r, email: emailController.text)))

  ;});
                }

              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Appcolors.violet100),
                minimumSize: WidgetStateProperty.all(Size(343.w, 56.h)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)))
              ),
              child: Text("Continue",style: TextStyle(fontSize: 24.sp,color: Colors.white),),
            
            
            ),
          ),
           
        ],
      ) ,
      
    );
  }
}
