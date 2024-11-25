import 'package:app/core/Services/sharedPrefsService.dart';
import 'package:app/features/auth/data/repository/userAuth_repository_impl.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:app/features/auth/domain/usecases/getBudgetUseCase.dart';
import 'package:app/features/auth/domain/usecases/loginUseCase.dart';
import 'package:app/features/auth/domain/usecases/logoutUseCase.dart';
import 'package:app/features/auth/domain/usecases/setPinUseCase.dart';
import 'package:app/features/auth/domain/usecases/signInUseCase.dart';
import 'package:app/features/auth/presentation/screens/authpages/budgetSelection.dart';
import 'package:app/features/auth/presentation/screens/authpages/forgot_password.dart';
import 'package:app/features/auth/presentation/screens/authpages/login.dart';
import 'package:app/features/auth/presentation/screens/authpages/pinSetterPage.dart';
import 'package:app/features/auth/presentation/screens/authpages/signUp.dart';
import 'package:app/features/auth/presentation/screens/welcomepages/welcome_screen.dart.dart';
import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:app/features/expenses/data/repository/ExpensesRepoImpl.dart';
import 'package:app/features/expenses/data/source/remote/expense_remote_data_source.dart';
import 'package:app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:app/features/expenses/domain/usecases/addExpenseUseCase.dart';
import 'package:app/features/expenses/domain/usecases/deleteExpenseUseCase.dart';
import 'package:app/features/expenses/domain/usecases/getExpensesUseCase.dart';
import 'package:app/features/expenses/domain/usecases/updateExpenseUseCase.dart';
import 'package:app/features/expenses/presentation/screens/homepage.dart';
import 'package:app/features/expenses/presentation/state/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'features/auth/domain/usecases/setBudgetUseCase.dart';
final getit=GetIt.instance;
void setup(){
  WidgetsFlutterBinding.ensureInitialized();
  getit.registerSingleton<ExpensesRepository>(Expensesrepoimpl(
   ExpenseRemoteDataSource()
  ));
}
void main()async{

  setup();
  await Sharedprefsservice().init(); 
  final sharedpref=Sharedprefsservice().prefs;
  final expenseRepo= getit<ExpensesRepository>();
  var userBloc=UserBloc(
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
          Signinusecase( UserauthRepositoryImpl(
            remotedatasource: Remotedatasource(),
            localedatasource: Localdatasource(sharedpref),
            localedatasourceSECURE: LocaledatasourceSECURE(const FlutterSecureStorage()),
      
          )),
          Setpinusecase( UserauthRepositoryImpl(
            remotedatasource: Remotedatasource(),
            localedatasource: Localdatasource(sharedpref),
            localedatasourceSECURE: LocaledatasourceSECURE(const FlutterSecureStorage()),       ),
            
      ),
      Setbudgetusecase( UserauthRepositoryImpl(
            remotedatasource: Remotedatasource(),
            localedatasource: Localdatasource(sharedpref),
            localedatasourceSECURE: LocaledatasourceSECURE(const FlutterSecureStorage()),       ),
        ),
     Getbudgetusecase( UserauthRepositoryImpl(
            remotedatasource: Remotedatasource(),
            localedatasource: Localdatasource(sharedpref),
            localedatasourceSECURE: LocaledatasourceSECURE(const FlutterSecureStorage()),       ),
)
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context)=>userBloc,child: const MyApp(),
      ),
      BlocProvider(create: (context)=>expenseBloc(Updateexpenseusecase(expenseRepo), DeleteExpenseusecase(expenseRepo), Addexpenseusecase(expenseRepo),Getexpensesusecase(expenseRepo), userBloc))
      
    ],
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
          routes: {
           "/welcome":(context)=>const welcomePage(),
           "/login":(context)=>const Login(),
           "/signup":(context)=>const Signup(),
           "/home":(context)=>const Homepage(),
          "/pinSet":(context)=>const Pinsetterpage(),
          "/forgotPassword":(context)=>const ForgotPassword(),
          "/setBudget":(context)=>const Budgetselection(),
        },
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            splashColor: Colors.transparent,
              fontFamily: "Inter",
            scaffoldBackgroundColor: Colors.white),
          home:BlocBuilder<UserBloc,UserState>(builder:(context,state){
          if (state is UserStateInitial){
            return const welcomePage() ;
           
          }
          if (state is UserStateLoaded){
            return const Homepage();
            
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
