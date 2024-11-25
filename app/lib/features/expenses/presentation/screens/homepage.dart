import 'dart:math';

import 'package:app/config/colors.dart';
import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math.dart' as math;
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final  pages=[home(),const Center(child: Text('Trans')),const Center(child: Center(child: Text('BUdget'))),const Text('PROFILE')];
  late int index;
  @override
    void initState() {
    index=0;

    // BlocProvider.of<expenseBloc>(context).add(ExpensesRequest());  
    BlocProvider.of<UserBloc>(context).add(GetBudgetEvent());
    super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
 floatingActionButton: const AnimatedAdd(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      //TODO Change the BottomNavigationBar with a bottomAPPBAR
    bottomNavigationBar: BottomNavigationBar(
        
        backgroundColor: Colors.white,
        
        
       type:BottomNavigationBarType.fixed , 
        
        showSelectedLabels:true,
        showUnselectedLabels: true,
     currentIndex: index,
        onTap: (i){
          setState(() {
            index=i;
          });
        },
        items: [
      BottomNavigationBarItem(icon:SvgPicture.asset("assets/icons/homeDisabled.svg"),activeIcon:SvgPicture.asset("assets/icons/homeEnabled.svg") ,label: "Home"),
      BottomNavigationBarItem(icon:SvgPicture.asset('assets/icons/transDisabled.svg'),activeIcon: SvgPicture.asset('assets/icons/transEnabled.svg'),label: "transactions"),
      BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/budgetDisabled.svg'),activeIcon: SvgPicture.asset('assets/icons/budgetEnabled.svg'),label: "budget"),
     BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/profileDisabled.svg'),activeIcon: SvgPicture.asset('assets/icons/profileEnabled.svg'),label: "Profile"),
        ],)
    );
  }

  
}

Widget home() {
   return  BlocBuilder<UserBloc,UserState>(builder: (context,state){
     if (state is UserStateLoading) {
      return const CircularProgressIndicator();
    } else if (state is UserStateError) {
      return const Text("ERROR");
    } else if (state is UserStateLoaded) {
      return  Column(
          children:[ Text('Account Balance',style: TextStyle(color: Appcolors.dark50,fontSize: 18.sp,fontWeight: FontWeight.w300),),
 Text(state.user.totalBalance.toString(),style: TextStyle(color: Appcolors.dark100
 ,fontWeight: FontWeight.w700,fontSize: 24.sp),),
  Row(
    children: [
      Container(
      padding:EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          color: Appcolors.green100,
          
          borderRadius: BorderRadius.circular(10),
        ),
      child: Text('INCOME',style: TextStyle(color: Appcolors.light100,fontWeight: FontWeight.w600,fontSize: 20.sp),),),
    
   Container(
       padding:EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          color: Appcolors.red100
          ,
          
          borderRadius: BorderRadius.circular(10),
        ),
      child: Text('OUTCOME',style: TextStyle(color: Appcolors.light100,fontWeight: FontWeight.w600,fontSize: 20.sp),),     
   ),
   ElevatedButton(onPressed: (){
     BlocProvider.of<UserBloc>(context).add(logoutEvent());
   }, child: const Text('Logout'))
    ],
  )    
 
  ]      );
    } else {
      return const Text("Unexpected state");
    }
    }); 
    
  }
class AnimatedAdd extends StatefulWidget {
  const AnimatedAdd({
    super.key,
  });

  @override
  State<AnimatedAdd> createState() => _AnimatedAddState();
}

class _AnimatedAddState extends State<AnimatedAdd> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _distance;
  @override
    void initState() {   
  super.initState();
  _controller=AnimationController(vsync: this,duration: const Duration(milliseconds:300));
    _animation=Tween<double>(begin: 0,end: 1.2).animate(_controller);
     _distance= Tween<double>(begin: 0,end:100).animate(CurvedAnimation(parent:_controller, curve: Curves.elasticInOut));
    }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context,child) {
        return Stack(
          children: [
            circleButton(45, Appcolors.red100,(){},"assets/icons/output.svg"),
circleButton(90, Appcolors.blue100,(){}, "assets/icons/trans.svg"),
circleButton(135, Appcolors.green100, (){},"assets/icons/input.svg"),

        GestureDetector(
         onTap: (){
                _close();
              },
              child: Transform.scale(
                scale: _animation.value,
                 
                child: close())),
          GestureDetector(
            onTap: (){
                _open();
              },
              child:Transform.scale(
              scale: _animation.value-1.2,
                child: add()) ),
          ],
        );
      }, animation: _animation,
    ) ; }

  _open(){
    _controller.forward();
  
  }
  _close(){
    _controller.reverse();
  }
  circleButton(double angle,Color color,void Function() onPressed,String path){
   final rad=math.radians(angle);
    return Transform(transform:
   Matrix4.identity()..translate(
      _distance.value*cos(rad),
        -_distance.value*sin(rad),
      ),
        child: GestureDetector(
        onTap:onPressed, 
          child: Container(
          padding: EdgeInsets.all(15.sp),
                decoration: BoxDecoration(
            color: color,
                borderRadius: BorderRadius.circular(200.r),
              ),
          child:  SvgPicture.asset(path),
                  ),
        ),
  );
  }
}

Widget add(){
  return Container(
    padding: EdgeInsets.all(15.sp),
    decoration: BoxDecoration(
      
      color: Appcolors.violet100,
      borderRadius:BorderRadius.all(Radius.circular(100.r)) 
    ),
    child: SvgPicture.asset('assets/icons/add.svg'),
  );
}
Widget close(){
  return Container(    padding: EdgeInsets.all(20.sp),
    decoration: BoxDecoration(
      
      color: Appcolors.red100,
      borderRadius:BorderRadius.all(Radius.circular(100.r)) 
    ),
    child: SvgPicture.asset('assets/icons/close.svg'),
);
}
