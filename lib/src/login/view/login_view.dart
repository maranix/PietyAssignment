import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:piety_assignment/blocs/blocs.dart';
import 'package:piety_assignment/src/login/login.dart';
import 'package:piety_assignment/src/login/widgets/send_otp_view.dart';
import 'package:piety_assignment/src/login/widgets/verify_otp_view.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  late final PageController _pageController;

  void _showToast(
    BuildContext context,
    MotionToastType type, {
    required String title,
    required String description,
  }) {
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
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.bounceIn,
                );
              case LogInStatus.otpSent:
                _showToast(
                  context,
                  MotionToastType.info,
                  title: 'OTP Sent',
                  description: 'An otp has been sent',
                );

                context.read<LogInBloc>().add(
                    const LogInStateUpdated(status: LogInStatus.verifyOTP));
              case LogInStatus.verifyOTP:
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.bounceIn,
                );
              case LogInStatus.verified:
                _showToast(
                  context,
                  MotionToastType.success,
                  title: 'OTP verified',
                  description: "You'll be redirected to a new page shortly",
                );

                context.read<AuthBloc>().add(AuthSuccess(user: state.user));
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
                  title: 'Login failed',
                  description: state.errorMessage,
                ),
            };
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            SendOTPView(),
            VerifyOTPView(),
          ],
        ),
      ),
    );
  }
}
