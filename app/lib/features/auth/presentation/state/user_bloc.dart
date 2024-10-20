import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/domain/usecases/loginUseCase.dart';
import 'package:app/features/auth/domain/usecases/logoutUseCase.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent,UserState> {
  final Logoutusecase logoutUseCase;
  final Localdatasource localdatasource;
  final Loginusecase loginUsecase;
  UserBloc(this.localdatasource, this.logoutUseCase, this.loginUsecase) : super(UserStateInitial()){

     _getUser();
    on<LoginEvent>((event, emit)async {
  final response=await loginUsecase(event.email, event.password);
  response.fold((l) => emit(UserStateError(l.message)), (r) => emit(UserStateLoaded(r)));
    });
   on<logoutEvent>((event,emit)async{
      final response=await logoutUseCase();
      response.fold((l) =>emit(UserStateError(l.message)), (r) => emit(UserStateInitial()));
    });
    on<UpdateUserEvent>((event,emit){
      emit(UserStateLoaded(event.user));
    });
      }
  void _getUser()async{
   final response=await localdatasource.getUser();
   response.fold((l)=>l, (r)=>add(UpdateUserEvent(r)));
  }

}
