import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
  return ScreenUtilInit(
      designSize:const Size(375, 812) ,
       minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child){
      
      return const MaterialApp(home: Placeholder(child: Text("Home Placeholder .."),),);
    },);
  }
}
