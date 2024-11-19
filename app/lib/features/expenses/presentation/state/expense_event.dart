part of 'expense_bloc.dart';

sealed class expenseEvent extends Equatable {
  const expenseEvent();

  @override
  List<Object> get props => [];
}

final class ExpensesRequest extends expenseEvent {}
final class ExpneseAdded extends expenseEvent {
  final Expense expense;
  const ExpneseAdded(this.expense);
}
final class ExpenseDeleted extends expenseEvent {
  final Expense expense;
  const ExpenseDeleted(this.expense);
}
final class ExpenseUpdated extends expenseEvent {
  final Expense expense;
  const ExpenseUpdated(this.expense);
}

