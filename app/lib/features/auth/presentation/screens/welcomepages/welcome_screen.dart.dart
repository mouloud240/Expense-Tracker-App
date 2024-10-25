import 'package:app/config/colors.dart';
import 'package:app/features/auth/presentation/screens/welcomepages/intropages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

class welcomePage extends StatelessWidget {
  const welcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top:120.h),
                child: IntroductionScreen(
                  pages: [Intropages.firstPage,Intropages.secondPage,Intropages.thirdPage],
                 dotsDecorator: DotsDecorator(size:Size(8.sp, 8.sp),activeSize:Size(15.sp, 15.sp) ,activeColor: Appcolors.violet100,color: Appcolors.light20), 
                  showNextButton: false,
                  showDoneButton: false,
                ),
              ),
            ),
            SizedBox(
              width: 343.w,
              height: 56.h,
              child: ElevatedButton(onPressed: (){ 
Navigator.of(context).pushNamed("/signup");
              },
                style: ButtonStyle(elevation: WidgetStatePropertyAll(0),backgroundColor: WidgetStatePropertyAll(Appcolors.violet100),shape:const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))) ), child: Text('Sign Up',style: TextStyle(fontSize: 18.sp,color:Colors.white),)),
            ),
            SizedBox(
              height:16.h ,
            ),
            SizedBox(
          width: 343.w,
          height: 56.h, 
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).pushNamed("/login");
              },style: ButtonStyle(elevation: WidgetStatePropertyAll(0),backgroundColor: WidgetStatePropertyAll(Appcolors.violet20),shape:WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))))), child: Text('Login ',style: TextStyle(fontSize: 18.sp,color: Appcolors.violet80),), )),
    
          ],
        ),
      ),
    ); 
  }
}
