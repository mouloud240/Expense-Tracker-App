import 'package:app/config/colors.dart';
import 'package:app/features/auth/presentation/screens/welcomepages/intropages.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class welcomePage extends StatelessWidget {
  const welcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top:200.h),
                child: IntroductionScreen(
                  pages: [Intropages.firstPage,Intropages.firstPage],
                  
                  showNextButton: false,
                  showDoneButton: false,
                ),
              ),
            ),
            SizedBox(
              width: 343.w,
              height: 56.h,
              child: ElevatedButton(onPressed: (){ },
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Appcolors.violet100),shape:const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))) ), child: Text('Sign Up',style: GoogleFonts.inter(color:Colors.white,fontSize: 18.sp),)),
            ),
            SizedBox(
              height:16.h ,
            ),
            SizedBox(
          width: 343.w,
          height: 56.h, 
              child: ElevatedButton(onPressed: (){},style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Appcolors.violet20),shape:WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))))), child: Text('Login ',style: GoogleFonts.inter(color: Appcolors.violet100),), )),
        
          ],
        ),
      ),
    ); 
  }
}
