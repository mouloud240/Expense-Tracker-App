import 'package:app/config/colors.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:app/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final RegExp passRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  final RegExp mailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool acceptedTerms=false;
  final _formkey=GlobalKey<FormState>();
 final TextEditingController nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final fieldsParams=[
      {
        "controller":nameController,
        "regexp":RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)*$'),
        "hintText":"Name",
        "validator":(value){
          if(value!.isEmpty){
            return "Name is required";
          } 
          return null;
        }
      },
      {
        "controller":emailController,
        "regexp":mailRegex,
        "hintText":"Email",
        "validator":(value){
          if(value!.isEmpty){
            return "Email is required";
          }
          if(!mailRegex.hasMatch(value)){
            return "Invalid Email";
          }
          return null;
        }
      },
      {
        "controller":passwordController,
        "regexp":passRegex,
        "hintText":"Password",
        "validator":(value){
          if(value!.isEmpty){
            return "Password is required";
          }
          if(!passRegex.hasMatch(value)){
            return "Invalid Password";
          }
          return null;
        },
       "isPasswordVisible":!isPasswordVisible,
      "SuffixAction":(){
        setState(() {
          isPasswordVisible=!isPasswordVisible;
        });
      },
      "suffixIcon":!isPasswordVisible?Icons.visibility:Icons.visibility_off
      } 

    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle:true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Sign Up",style: TextStyle(color: Appcolors.dark100,fontWeight: FontWeight.w500),),
        toolbarHeight: 44.h,
      ),
      body: BlocListener<UserBloc,UserState>(
        listener: (context,state){
        if (state is UserStateError){
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message))
        );}
         if (state is UserStateLoaded){
        Navigator.of(context).pushNamed("/pinSet");
        }
      },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height+10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                Form(
               key:_formkey,
                  child: Column
                (
                    children: [
            
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: fieldsParams.length,
                        separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
                        itemBuilder: (item,index){
                          
                         return      Field(controller: fieldsParams[index]['controller'] as TextEditingController, regexp:fieldsParams[index]['regexp'] as RegExp, hintText: fieldsParams[index]['hintText'] as String, validator: fieldsParams[index]['validator'] as String?Function(String?), isPasswordVisible: fieldsParams[index]['isPasswordVisible']!=null?fieldsParams[index]['isPasswordVisible'] as bool:false, SuffixAction: fieldsParams[index]['SuffixAction'] as Function()?, suffixIcon: fieldsParams[index]['suffixIcon'] as IconData?,);
                      }),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: OverflowBar(
                            
                            children: [
                            SizedBox(
                              child: Checkbox(
                                side: BorderSide(color: Appcolors.violet100,width: 3),  
                                  value: acceptedTerms, onChanged: (val){
                                setState(() {
                                  acceptedTerms=val!;
                                }); 
                              }),
                            ),
                              RichText(text: TextSpan(
                                text: "By signing up you agree to our ",
                                style: TextStyle(color: Appcolors.dark100,fontSize: 16.sp,fontWeight: FontWeight.w500, ),
                                children: <TextSpan>[
                                 TextSpan(
                                    text: "Terms of \n Service and Privacy Policy",
                                    style: TextStyle(color: Appcolors.violet100,fontSize: 16.sp,fontWeight: FontWeight.w500, ),
                                   recognizer:TapGestureRecognizer(
                                    )..onTap=()=>print("Terms of Service and Privacy Policy")
                                      
                                  ),
                                
                                ],
                              ))
                            
                                        ],),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ElevatedButton(
                          onPressed: (){
                            if(_formkey.currentState!.validate()){
                        
 if (acceptedTerms){
 BlocProvider.of<UserBloc>(context).add(
RegisterEvent(emailController.text, passwordController.text,nameController.text) 
 );} 
  else {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(  "Please accept the terms of service and privacy policy" )));
  }
 
 
                        }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Appcolors.violet100),
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),
                            minimumSize: WidgetStateProperty.all(Size(double.infinity, 64.h))
                          ),
                          child: Text("Sign Up",style: TextStyle(color: Appcolors.light100,fontWeight: FontWeight.w600,fontSize: 20.sp),),
                        ),
                      ),
                      SizedBox(
              height:  20.h,
            ),
            
                   Align(
                         alignment: AlignmentDirectional.center,
                        
                        child: Text("Or with",style: TextStyle(color: Appcolors.light20,fontWeight: FontWeight.w600,fontSize: 16.sp),))
                    
              ,Padding(padding: EdgeInsets.all(20),
               child: ElevatedButton(
                          
            style: ButtonStyle(
                            padding:WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10.h)) ,
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                            minimumSize: WidgetStatePropertyAll(Size(343.w, 64.h)),
              shape:WidgetStatePropertyAll(RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(27.r),
                              side:BorderSide(
                                color:Appcolors.light60 
                                ,width: 3
                              )
                              
                              
                            ),),  
                          ),
                          onPressed: (){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Feature Coming soon")));                }, child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/google.svg"),
                              SizedBox(width: 10.w,),
                              Text("Sign up  with Google",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: Appcolors.dark100),),  
                            
                            ],
                          ) ,
                      )
                      ),
                      RichText(text: TextSpan(
                        style: TextStyle(color: Appcolors.light20,fontSize: 16.sp,fontWeight: FontWeight.w500),
                        text: "Already have an account? ",
                        children: [
                          TextSpan(
                            text: " Login",
                            style: TextStyle(color: Appcolors.violet100,fontSize: 16.sp,fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()..onTap=()=>Navigator.of(context).pushNamed("/login")
                          )
                        ]
                    ),),
                    ],
            
                  )),
                Spacer(flex: 2,),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
