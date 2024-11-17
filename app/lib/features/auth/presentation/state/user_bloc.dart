import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/usecases/loginUseCase.dart';
import 'package:app/features/auth/domain/usecases/logoutUseCase.dart';
import 'package:app/features/auth/domain/usecases/setBudgetUseCase.dart';
import 'package:app/features/auth/domain/usecases/setPinUseCase.dart';
import 'package:app/features/auth/domain/usecases/signInUseCase.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent,UserState> {
  final Logoutusecase logoutUseCase;
  final Localdatasource localdatasource;
  final Loginusecase loginUsecase;
  final Signinusecase signinUsecase;
  final Setpinusecase setpinusecase;
  final Setbudgetusecase setBudgetUseCase;
   
  UserBloc(this.localdatasource, this.logoutUseCase, this.loginUsecase, this.signinUsecase, this.setpinusecase, this.setBudgetUseCase) : super(UserStateInitial()){

    on<LoginEvent>((event, emit)async {
  final response=await loginUsecase(event.email, event.password);
  response.fold((l) {
        return  emit(UserStateError(l.message));}, (r) {
         
          return  emit(UserStateLoaded(r));});
      
    });
   on<logoutEvent>((event,emit)async{
      emit(UserStateLoading());
      final response=await logoutUseCase();
      response.fold((l) =>emit(UserStateError(l.message)), (r) => emit(UserStateInitial()));
    });
    on<UpdateUserEvent>((event,emit)
    {
      emit(UserStateLoaded(event.user));
    });
    on<RegisterEvent>((event,emit)async{
      final response=await signinUsecase(User(MonthlyIncome: Money(0,"DZD"), totalBalance: Money(0, "DZD"), name: event.name, hashedPassword:event.password , pin:"0000", email: event.email, uid:"", payDay: DateTime.now()));
      response.fold((l) =>emit(UserStateError(l.message)), (r) async{
    emit(UserStateLoaded(r));
      });
   });
    on<ChangePinEvent>((event,emit)async{
      final response= await setpinusecase(event.pin);
      response.fold((l) =>emit(UserStateError(l.message)), (r) =>emit(UserStateLoaded(r)));
    });
    
    on<SetBudgetEvent>((event,emit)async{
    final response=await setBudgetUseCase(event.budget); 
    response.fold((l) =>emit(UserStateError(l.message)), (r) =>emit(UserStateLoaded(r)));
    });
      }

}
