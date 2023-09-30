import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:piety_assignment/blocs/blocs.dart';
import 'package:piety_assignment/src/login/login.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  late final PageController _pageController;

  void _showToast(BuildContext context, MotionToastType type, String title,
      String description) {
    return switch (type) {
      MotionToastType.info => MotionToast.info(
          title: Text(title),
          description: Text(description),
        ).show(context),
      MotionToastType.success => MotionToast.success(
          title: Text(title),
          description: Text(description),
        ).show(context),
      MotionToastType.error => MotionToast.error(
          title: Text(title),
          description: Text(description),
        ).show(context),
      _ => null,
    };
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LogInBloc, LogInState>(
          listener: (context, state) {
            switch (state.status) {
              case LogInStatus.initial:
                _pageController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.bounceIn,
                );
              case LogInStatus.otpSent:
                _showToast(
                  context,
                  MotionToastType.info,
                  'OTP Sent',
                  'An otp has been sent',
                );

                _pageController.animateTo(
                  1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.bounceIn,
                );
              case LogInStatus.verified:
                _showToast(
                  context,
                  MotionToastType.success,
                  'OTP verified',
                  "You'll be redirected to a new page shortly",
                );
              default:
            }
          },
        ),
        BlocListener<LogInBloc, LogInState>(
          listener: (context, state) {
            return switch (state.errorStatus) {
              LogInErrorStatus.none => null,
              _ => _showToast(
                  context,
                  MotionToastType.error,
                  'Login failed',
                  state.errorMessage,
                ),
            };
          },
        ),
      ],
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [],
        ),
      ),
    );
  }
}
