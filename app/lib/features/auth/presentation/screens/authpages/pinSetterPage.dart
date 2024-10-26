import 'package:app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pinsetterpage extends StatefulWidget {
  const Pinsetterpage({super.key});

  @override
  State<Pinsetterpage> createState() => _PinsetterpageState();
}
 
class _PinsetterpageState extends State<Pinsetterpage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
 late  String CurrentPin;
  final  Buttons=[
    "1","2","3",
    "4","5","6",
    "7","8","9",
    "X","0","->",
];
  @override
    void initState() {
      // TODO: implement initState
    controller=AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    CurrentPin="";
    }
   @override

  Widget build(BuildContext context) {
      final Animation<double> offsetAnimation =
    Tween(begin: 0.0, end: 40.0).chain(CurveTween(curve: Curves.elasticIn)).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
    return Scaffold(
      backgroundColor:Appcolors.violet100,
      body:SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           SizedBox(
              height: 45.h,
            ), 
            Text("Let's Setup Your Pin",style: TextStyle(
              color: Appcolors.light100,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500
            ),),
           SizedBox(
              height: 32.h,
             child: AnimatedBuilder(
               animation: offsetAnimation,
               builder: (context,child) {
                 return Padding(
                    
                   padding: EdgeInsets.only(left: 24+offsetAnimation.value),
                   child: ListView.separated(
                      separatorBuilder: (context,index)=>SizedBox(width: 10.w,),
                      shrinkWrap: true,
                      scrollDirection:Axis.horizontal,
                     itemCount: 4,
                      itemBuilder: (context,index)=>
                   Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border(
                              top: BorderSide(color: Appcolors.light20),
                              left: BorderSide(color: Appcolors.light20),
                              right:BorderSide(color: Appcolors.light20),
                              bottom: BorderSide(color: Appcolors.light20,width: 2.w)
                            ),
                            color:index<CurrentPin.length?controller.value==0? Colors.white:Colors.red:
                            Appcolors.violet100,
                          ),
                        ) ),
                 );
               }
             ),
           ),     
          SizedBox(
              height: MediaQuery.of(context).size.height*0.7, 
              width: MediaQuery.of(context).size.width,
            child: GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)
            , itemCount: Buttons.length
              , itemBuilder:(context,index){
                  return GestureDetector(
                    onTap: (){
                      if (Buttons[index]=="X"){
                      if (CurrentPin.length==1){
                        setState(() {
                         CurrentPin="";                           
                                                  });
                      }
                       setState(() {
                                                  
                       CurrentPin=CurrentPin.substring(0,CurrentPin.length-1);
                                                });
                      }
                      if (Buttons[index]!="->"&&Buttons[index]!="X"){
                       setState(() {
                      CurrentPin+=Buttons[index]; 
                                                });
                      }
                    if (Buttons[index]=="->"){
                      if (CurrentPin.length!=4){
                      //TODO replace with Stronger Vibrations 
                      HapticFeedback.vibrate();
                      controller.forward(from: 0.0); 
                      return ;
                      }
                     //handle Logic Here
                    }
          
                    },
                    child: Padding(
                      padding:EdgeInsets.all(36.sp),
                      child: Text(Buttons[index],style: TextStyle(
                        color: Colors.white,
                         fontSize: 48.sp,
                      ),),
                    ),
                  );
                }),
          )  
          ],
        
        ),
      ) ,
    );
  }
}
