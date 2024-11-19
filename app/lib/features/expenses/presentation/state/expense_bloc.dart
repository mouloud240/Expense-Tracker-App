// ignore_for_file: camel_case_types

import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:app/features/expenses/domain/usecases/addExpenseUseCase.dart';
import 'package:app/features/expenses/domain/usecases/deleteExpenseUseCase.dart';
import 'package:app/features/expenses/domain/usecases/getExpensesUseCase.dart';
import 'package:app/features/expenses/domain/usecases/updateExpenseUseCase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class expenseBloc extends Bloc<expenseEvent, expenseState> {
  Addexpenseusecase addexpenseusecase;
  Getexpensesusecase getexpensesusecase;
  DeleteExpenseusecase deleteExpenseusecase;
  Updateexpenseusecase updateexpenseusecase; 
  UserBloc userBloc;
  expenseBloc(this.updateexpenseusecase,this.deleteExpenseusecase,this.addexpenseusecase,this.getexpensesusecase,this.userBloc) : super(expenseInitial()) {
    on<ExpneseAdded>((event, emit) async {
      if (state !is expensesLoaded){
      emit(const expensesError("Expneses Not loaded", []));
      return;
      }
        final res=await addexpenseusecase(event.expense);
        res.fold((l)=>emit(expensesError(l.message,(state as expensesLoaded).expenses)), (r){
          if (state is expensesLoaded){
           final currentExpenses=(state as expensesLoaded).expenses;
           emit(expensesLoaded([...currentExpenses,event.expense]));
           userBloc.add(SetBudgetEvent(r));
          }
        });
    });
    on<ExpensesRequest>((event, emit) async {
      emit(expensesLoading());
      final res=await getexpensesusecase();
      res.fold((l)=>emit(expensesError(l.message,const[])), (r)=>emit(expensesLoaded(r)));
    });
    on<ExpenseDeleted>((event, emit) async {
      if (state !is expensesLoaded){
      emit(const expensesError("Expneses Not loaded", []));
      return;
      }
      final res=await deleteExpenseusecase(event.expense);
      res.fold((l)=>emit(expensesError(l.message,(state as expensesLoaded).expenses)), (r){
        if (state is expensesLoaded){
          final currentExpenses=(state as expensesLoaded).expenses;
          emit(expensesLoaded(currentExpenses.where((element) => element.id!=event.expense.id).toList()));
          userBloc.add(SetBudgetEvent(r));
        }
      });
    });
  }

  

}
