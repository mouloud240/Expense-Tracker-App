import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
        ],
      );
    } else {
      return const Text("Unexpected state");
    }
  }
}
