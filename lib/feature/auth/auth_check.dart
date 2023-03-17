import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome_task/feature/auth/cubit/auth_cubit.dart';
import 'package:welcome_task/feature/main/main_screen.dart';
import '../../service/api/repository/donut_repository.dart';
import 'cubit/auth_state.dart';
import 'sing_in_page.dart';

class AuthCheck extends StatelessWidget {
  final Connectivity connectivityMonitor;
  final DonutRepository donutRepository;
  const AuthCheck({
    Key? key,
    required this.connectivityMonitor,
    required this.donutRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          () => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              if (state is Authenticated) ...[
                MainPage(
                  connectivityMonitor: connectivityMonitor,
                  donutRepository: donutRepository,
                ),
              ] else if (state is Loading) ...[
                const Center(
                  child: CircularProgressIndicator(),
                )
              ] else ...[
                SignInPage(
                  connectivityMonitor: connectivityMonitor,
                  donutRepository: donutRepository,
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
