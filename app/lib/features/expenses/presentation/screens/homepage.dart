// ignore_for_file: camel_case_types

import 'dart:math';

import 'package:app/config/colors.dart';
import 'package:app/features/auth/presentation/screens/authpages/profilePage.dart';
import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:app/features/expenses/presentation/state/expense_bloc.dart';
import 'package:app/features/expenses/presentation/widgets/expenseListTile.dart';
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
  final  pages=[const home(),const Center(child: Text('Trans')),const Center(child: Center(child: Text('BUdget'))),const Profilepage()];
  late int index;
  @override
    void initState() {
    index=0;
    if (context.read<expenseBloc>().state is expenseInitial){
        BlocProvider.of<UserBloc>(context).add(GetBudgetEvent());

      BlocProvider.of<expenseBloc>(context).add(ExpensesRequest());
      
    }

      //TODO Fix the behavior of the multiple calls
        super.initState();

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
 floatingActionButton: const AnimatedAdd(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {},
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Appcolors.violet100,size:40.0 ))
        ],
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Appcolors.yellow40.withOpacity(0.5),
      ),
      
      body: IndexedStack(
        index: index,
        children: pages,
      ),
          bottomNavigationBar: BottomAppBar(
        height: 86.h,
        color: Appcolors.light80, // Background color
        shape: const CircularNotchedRectangle(), // Optional: Notched shape
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(child: buildNavItem(0, 'assets/icons/homeDisabled.svg', 'assets/icons/homeEnabled.svg', "Home")),
            buildNavItem(1, 'assets/icons/transDisabled.svg', 'assets/icons/transEnabled.svg', "Transactions"),
            SizedBox(width: 48.w), // Space for the FloatingActionButton if needed
            buildNavItem(2, 'assets/icons/budgetDisabled.svg', 'assets/icons/budgetEnabled.svg', "Budget"),
            buildNavItem(3, 'assets/icons/profileDisabled.svg', 'assets/icons/profileEnabled.svg', "Profile"),
          ],
        ),
      ),    );
  }

  Widget buildNavItem(int itemIndex, String iconPath, String activeIconPath, String label) {
    bool isSelected = index == itemIndex;
    return IconButton(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isSelected ? activeIconPath : iconPath,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Appcolors.violet100 : Appcolors.dark50,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
      onPressed: () {
        setState(() {
          index = itemIndex;
        });
      },
      tooltip: label, // Optional: shows label on long press
    );
  }
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
        return FittedBox(
          child: Stack(
            children: [
              circleButton(45, Appcolors.red100,(){
                Navigator.of(context).pushNamed("/addExpense");
              },"assets/icons/output.svg"),
          circleButton(90, Appcolors.blue100,(){print("Clicked Blue");}, "assets/icons/trans.svg"),
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
          ),
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
        onTap:(){
          print("Tapped");
          onPressed();
        }, 
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
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return   BlocBuilder<UserBloc,UserState>(builder: (context,state){
     if (state is UserStateLoading) {
      return const CircularProgressIndicator();
      
    } 
    else if (state is UserStateInitial) {
     Navigator.of(context).pushNamedAndRemoveUntil("/login", (route)=>false);
     return const Text("UnAuthorized");
    }
      else if (state is UserStateError) {
      return const Text("ERROR");
    } else if (state is UserStateLoaded) {
      return  Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150.h),
            child: Column(
                children:[             SizedBox(
              height:200.h ,
              width: 375.w,
              child:const Center(child:Text("Chart Here") ,),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:10.sp),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Transactions',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.w600),),
              ElevatedButton(onPressed: (){

            BlocProvider.of<expenseBloc>(context).add(ExpensesRequest());
    BlocProvider.of<UserBloc>(context).add(GetBudgetEvent());
              }, child: const Text("See all"))
            ],
                 
                ),
              ),
              
              Expanded(
                child: BlocBuilder<expenseBloc,expenseState>(builder: (context,state){
                if (state is expensesLoaded){
                return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: ListView.separated(
            shrinkWrap: false,
            itemBuilder: (context,index){
              return ExpenseTile(expense: state.expenses[index]);
            }, 
            separatorBuilder:(context,index)=>SizedBox(height: 7.h,), //TODO fix this,), 
            itemCount:3),
                );
                }
                else if (state is expensesLoading){
            
                return const SizedBox(
                 height: 10,
                 width: 40,
                child: CircularProgressIndicator());
                }
                else if (state is expenseInitial){
                return const CircularProgressIndicator(); 
                }
                else if (state is expensesError){
                return Text(state.message);
                }
                else{
                return const Text("Unexpected state");
                }
                }),
              )
                 //TODO Optimize using Slivers
            
                ]      ),
          ),
              Container(
              height: 170.h,
              decoration: BoxDecoration(

              color: Appcolors.yellow40.withOpacity(0.5),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r),bottomRight: Radius.circular(20.r)),
              ),
              child: Column(
              children: [Text('Account Balance',style: TextStyle(color: Appcolors.dark50,fontSize: 18.sp,fontWeight: FontWeight.w300),), Text(state.user.totalBalance.toString(),style: TextStyle(color: Appcolors.dark100 ,fontWeight: FontWeight.w700,fontSize: 24.sp),), 
SizedBox(height: 24.h,),
Row( mainAxisAlignment: MainAxisAlignment.spaceAround, children: [ Container( padding:EdgeInsets.all(15.sp), decoration: BoxDecoration( color: Appcolors.green100, borderRadius: BorderRadius.circular(25.r), ), child: Text('INCOME',style: TextStyle(color: Appcolors.light100,fontWeight: FontWeight.w600,fontSize: 20.sp),),),

Container( 
padding:EdgeInsets.all(15.sp), decoration: BoxDecoration( color: Appcolors.red100 , borderRadius: BorderRadius.circular(25.r), ), child: Text('OUTCOME',style: TextStyle(color: Appcolors.light100,fontWeight: FontWeight.w600,fontSize: 20.sp),), ), ], )   ,],
              ),
              )
        ],
      );
    } else {
      return const Text("Unexpected state");
    }
    }); 
  }
}
