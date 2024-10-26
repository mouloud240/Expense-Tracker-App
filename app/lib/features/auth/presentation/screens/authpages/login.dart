import 'package:app/config/colors.dart';
import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:app/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RegExp passRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  final RegExp mailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Appcolors.dark100,
                fontSize: 19.sp)),
        backgroundColor: Appcolors.light100,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 44.h,
        
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserStateError) {
          print("error ");
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Hehe")));
          }
          if (state is UserStateLoaded) {
            Navigator.of(context).pushNamed("/home");
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: 56.h,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Field(
                    controller: emailController,
                    regexp: mailRegex,
                    hintText: "Email",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required Filed";
                      }
                    if (!mailRegex.hasMatch(value)) {
                      return "Invalid Email";
                  
                    }
                      return null;
                    },
                  ),
                  Field(controller: passwordController, regexp: passRegex, hintText: "Password", validator: (value){
                                          if (value!.isEmpty) {
                          return "Required Filed";
                        }
                       //TODO add Strong Password Requirement
                        return null;

                },
                isPasswordVisible: !isPasswordVisible,
                suffixIcon: isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                SuffixAction: () {
                    setState(() {
                                  isPasswordVisible = !isPasswordVisible;        
                                        });
                  }
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Appcolors.violet100),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r))),
                            minimumSize:
                                WidgetStateProperty.all(Size(343.w, 56.h))),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            BlocProvider.of<UserBloc>(context).add(LoginEvent(
                                emailController.text, passwordController.text));
                          }
                        },
                        child: Text("Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Appcolors.light100))),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Appcolors.violet100,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account yet?",
                  style: TextStyle(
                      color: Appcolors.light20,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/signUp");
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Appcolors.violet100,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
