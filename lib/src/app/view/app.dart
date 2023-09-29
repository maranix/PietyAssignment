import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piety_assignment/blocs/location_bloc/location_bloc.dart';
import 'package:piety_assignment/routes/routes.dart';
import 'package:piety_assignment/src/home/home.dart';

class PietyApp extends StatelessWidget {
  const PietyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.purple,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const HomePage(),
      },
    );
  }
}
