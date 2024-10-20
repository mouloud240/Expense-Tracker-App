import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Intropages {
  static final firstPage=PageViewModel(title:"Gain total Control Over your Money", body: "Become your own money manager and make every cent count", image:SvgPicture.asset("assets/icons/moneyhold.svg") 
,
decoration: PageDecoration(pageMargin: EdgeInsets.all(0),titleTextStyle: GoogleFonts.inter(fontSize:25.sp,fontWeight: FontWeight.w600))
  );
}
