import 'package:app/config/colors.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 9.w),
        decoration: BoxDecoration(
          color: Appcolors.light60,
          
          borderRadius: BorderRadius.circular(20.r),
        ),
        child:Row(
          children: [
          
          //FIX Icon HERE,
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(200.r)
              ),
            width: 39.w,
              height: 39.h,
              child: Center(child: Text("Icon"))),
            SizedBox(width: 10.w,),
            SizedBox(
              width: 274.w,
              child: Column(children: [
              
               Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [              Text(expense.category.name,style: TextStyle(color: Appcolors.dark50,fontSize: 19.sp,fontWeight: FontWeight.w700),),
                Text("-${expense.amount.toSymbol()}",style: TextStyle(color: Appcolors.red100
                ,fontWeight: FontWeight.w700,fontSize: 20.sp),),
               ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(expense.name,style: TextStyle(color: Appcolors.dark25,fontWeight: FontWeight.w500,fontSize: 16.sp),),
                    SizedBox(width: 20.w,),
                    Text(DateFormat.jm().format(expense.date),style: TextStyle(color: Appcolors.dark25,fontWeight: FontWeight.w500,fontSize: 16.sp),),
                  ],
                )
              ],),
            )

          ],
        )      ),
      
    );
  }
}
