import 'package:flutter/material.dart';
import 'package:piety_assignment/blocs/blocs.dart';
import 'package:piety_assignment/routes/routes.dart';
import 'package:piety_assignment/src/login/login.dart';
import 'package:piety_assignment/src/signup/view/signup_page.dart';

class PietyApp extends StatelessWidget {
  const PietyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => LocationBloc()),
      ],
      child: const _AppConfiguration(),
    );
  }
}

class _AppConfiguration extends StatelessWidget {
  const _AppConfiguration();

  @override
  Widget build(BuildContext context) {
    bool routePredicate(Route route) {
      return route.settings.name == '/';
    }

    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.purple,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthStatus.unauthenticated:
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.login, routePredicate);
                  case AuthStatus.signUpInProgress:
                    Navigator.pushNamedAndRemoveUntil(context, Routes.signup,
                    routePredicate);
                  case AuthStatus.authenticated:
                    Navigator.pushNamedAndRemoveUntil(context, Routes.home,
                    routePredicate);
                  default:
                    const SizedBox.shrink();
                }
              },
            ),
        Routes.login: (context) => const LogInPage(),
        Routes.signup: (context) => const SignUpPage(),
      },
    );
  }
}
