import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piety_assignment/src/login/login.dart';
import 'package:piety_assignment/src/login/view/login_view.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LogInBloc(),
      child: const LogInView(),
    );
  }
}
