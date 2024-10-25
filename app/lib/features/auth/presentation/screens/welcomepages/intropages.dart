import 'package:app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
final PageDecoration _pageDecoration= PageDecoration(pageMargin: const EdgeInsets.all(0),titleTextStyle:TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w800),bodyTextStyle: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: Appcolors.light20,),bodyAlignment: Alignment.center );
class Intropages { 
  static final firstPage=PageViewModel(title:"Gain total Control Over your Money", body: "Become your own money manager and make every cent count", image:SizedBox(
  width: 265.w,
  height: 265.h,
    child: FittedBox(fit: BoxFit.cover,child: SvgPicture.asset("assets/icons/moneyhold.svg",))) 
,
decoration: _pageDecoration );
 static final secondPage=PageViewModel(title:"Know where your money goes", body: "Track your transaction easily,with categories and financial report", image:SizedBox(
  width: 265.w,
  height: 265.h,
    child: FittedBox(fit:BoxFit.cover,child: SvgPicture.asset(alignment: Alignment.topCenter,"assets/icons/moneyPaper.svg",width: 343.sp,height: 343.sp,))) 
    
,
decoration:_pageDecoration,
  );
 static final thirdPage=PageViewModel(title:"Planning ahead", body: "Setup your budget for each category so you in control", image:SizedBox(child: SizedBox(
  width: 265.w,
  height: 265.h, 
child: FittedBox(fit:BoxFit.cover,child: SvgPicture.asset("assets/icons/plan.svg")))) 
    
,
decoration:_pageDecoration,
  );

}
