import 'package:app/features/auth/data/repository/userAuth_repository_impl.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/usecases/loginUseCase.dart';
import 'package:app/features/auth/domain/usecases/logoutUseCase.dart';
import 'package:app/features/auth/presentation/screens/welcomepages/welcome_screen.dart.dart';
import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  final sharedpref=await SharedPreferences.getInstance();
  runApp(BlocProvider(
    create: (context)=>UserBloc(
      Localdatasource(sharedpref),
     Logoutusecase( UserauthRepositoryImpl(
        remotedatasource: Remotedatasource(),
        localedatasource: Localdatasource(sharedpref),
        localedatasourceSECURE: LocaledatasourceSECURE(const FlutterSecureStorage()),
      )),
      Loginusecase( UserauthRepositoryImpl(
        remotedatasource: Remotedatasource(),
        localedatasource: Localdatasource(sharedpref),
        localedatasourceSECURE: LocaledatasourceSECURE(const FlutterSecureStorage()),
      )),
    ),
    child: const MyApp(),
  ));
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
      
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          home:BlocBuilder<UserBloc,UserState>(builder:(context,state){
          if (state is UserStateInitial){
            return welcomePage() ;
           
          }
          if (state is UserStateLoaded){
            return Scaffold(
              body: Center(
                child: Text(state.user.name),
              ), 
            );
          }
         if (state is UserStateError){
            return Scaffold(
              body: Center(
                child: Text(state.message),
              ), 
            );
          }
          return const Scaffold(
            body: Center(
              child: Text("Loading"),
            ), 
          );
        } ));
    },);
  }
}
