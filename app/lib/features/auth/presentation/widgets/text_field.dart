import 'package:app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Field extends StatelessWidget {
  const Field({
    super.key,
    required this.controller,
    required this.regexp,
    this.isPasswordVisible=false, required this.hintText, required this.validator,
   this.suffixIcon, this.SuffixAction
  });
  final IconData? suffixIcon;
  final Function()? SuffixAction;
 final String  hintText;
 final String? Function(String?) validator; 
  final TextEditingController controller;
  final RegExp regexp;

   final bool isPasswordVisible ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      child: TextFormField(
         obscureText: isPasswordVisible, 
        controller: controller,
            validator:validator,
        decoration: InputDecoration(
                  
            contentPadding: EdgeInsets.symmetric(vertical: 19.h,horizontal: 15.w),
          hintText: hintText,
          suffixIcon:suffixIcon!=null?IconButton(onPressed: SuffixAction, icon: Icon(suffixIcon)):null,
      
          hintStyle: TextStyle(color: Appcolors.light20,fontSize: 16.sp),
          enabledBorder: OutlineInputBorder(
          
            borderSide: BorderSide(color: Appcolors.light40),
              borderRadius: BorderRadius.circular(20.r),
          ),
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Appcolors.light40),
              borderRadius: BorderRadius.circular(20.r),
                   
            ),
              errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Appcolors.red100),
              borderRadius: BorderRadius.circular(20.r)
              ),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r),borderSide: BorderSide(color: Appcolors.red100))
                  
        ),
                  
        ),
    );
  }
}
