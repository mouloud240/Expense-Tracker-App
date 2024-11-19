// ignore_for_file: camel_case_types

part of 'expense_bloc.dart';

sealed class expenseState extends Equatable {
  const expenseState();

  @override
  List<Object> get props => [];
}

final class expenseInitial extends expenseState {}
final class expensesLoading extends expenseState{}
final class expensesLoaded extends expenseState{
  final List<Expense> expenses;
  const expensesLoaded(this.expenses);
  void copyWith({List<Expense>? expenses}){
    expensesLoaded(expenses??this.expenses);
  }
}
final class expensesError extends expenseState{
  final String message;
  final List<Expense> expenses;
  const expensesError(this.message, this.expenses);
}

