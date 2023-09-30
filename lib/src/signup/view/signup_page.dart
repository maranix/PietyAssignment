import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piety_assignment/src/signup/bloc/signup_bloc.dart';
import 'package:piety_assignment/src/signup/view/signup_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(),
      child: const SignUpView(),
    );
  }
}
