import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:app/features/expenses/data/models/Expense-Model.dart';
import 'package:app/features/expenses/presentation/state/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
    void initState() {
     BlocProvider.of<expenseBloc>(context).add(ExpensesRequest());  
    super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        print("Current State: $state");
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Homepage"),
          ),
          body: Center(
            child: _buildBody(state),
          ),
        );
      },
    );
  }

  Widget _buildBody(UserState state) {
    if (state is UserStateLoading) {
      return const CircularProgressIndicator();
    } else if (state is UserStateError) {
      return Text("Error: ${state.message}");
    } else if (state is UserStateLoaded) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Name: ${state.user.name}"),
          const SizedBox(height: 8),
          Text("Email: ${state.user.email}"),
          const SizedBox(height: 8),
          Text("Balance: ${state.user.totalBalance}"),
          BlocBuilder<expenseBloc,expenseState>(
          builder: (context,state){
            if (state is expensesLoaded){
              return Column(
                children: state.expenses.map((e) => ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.category.name),
                  trailing: Text(e.amount.amount.toString()),
                )).toList(),
              );
            } else if (state is expensesLoading){
              return const CircularProgressIndicator();
            } else if (state is expensesError){
              return Text("Error: ${state.message}");
            } else {
              return const Text("Unexpected state");
            }
          },
          ),
          ElevatedButton(onPressed: (){
           BlocProvider.of<expenseBloc>(context).add(ExpensesRequest());
          }, child: Text('Refresh')),
          ElevatedButton(onPressed: (){
          final expense=ExpenseModel.fromJson(_expense).toEntity();
          print(expense.amount.amount);
          BlocProvider.of<expenseBloc>(context).add(ExpneseAdded(expense));
          }, child: Text('Add Expense'))
        ],
      );
    } else {
      return const Text("Unexpected state");
    }
  }
}
