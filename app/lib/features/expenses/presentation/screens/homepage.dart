import 'package:app/config/colors.dart';
import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:app/features/expenses/presentation/state/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

final Map<String, dynamic> _expense = 
{
  "Name": "Electricity Bill",
  "Date": "2024-11-15T00:00:00Z",
  "Category": {
    "Name": "Utilities",
    "Budget": {
      "Amount": 200,
      "Currency": "USD"
    }
  },
  "Amount": {
    "Amount": 150,
    "Currency": "USD"
  }
};

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final  pages=[home(),Center(child: const Text('Trans')),Center(child: Center(child: const Text('BUdget'))),const Text('PROFILE')];
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: IndexedStack(
        index: index,
        children: pages,
      ),
    bottomNavigationBar: BottomNavigationBar(
       type:BottomNavigationBarType.fixed , 
        showSelectedLabels:false,
        showUnselectedLabels: false,
     currentIndex: index,
        onTap: (i){
          setState(() {
            index=i;
          });
        },
        items: [
      BottomNavigationBarItem(icon:SvgPicture.asset("assets/icons/homeDisabled.svg"),activeIcon:SvgPicture.asset("assets/icons/homeEnabled.svg") ,label: "Home"),
      BottomNavigationBarItem(icon:SvgPicture.asset('assets/icons/transDisabled.svg'),activeIcon: SvgPicture.asset('assets/icons/transEnabled.svg'),label: "Add Expense"),
      BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/budgetDisabled.svg'),activeIcon: SvgPicture.asset('assets/icons/budgetEnabled.svg'),label: "Set Budget"),
     BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/profileDisabled.svg'),activeIcon: SvgPicture.asset('assets/icons/profileEnabled.svg'),label: "Profile"),
        ],)
    );
  }

  
}Widget home() {
   return  BlocBuilder<UserBloc,UserState>(builder: (context,state){
     if (state is UserStateLoading) {
      return const CircularProgressIndicator();
    } else if (state is UserStateError) {
      return Text("Error: ${state.message}");
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
   )
    ],
  )    
 
  ]      );
    } else {
      return const Text("Unexpected state");
    }
    }); 
    
  }
