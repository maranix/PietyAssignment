import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piety_assignment/src/app/observer.dart';
import 'package:piety_assignment/src/app/view/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Add firebase config
  // await Firebase.initializeApp();

  Bloc.observer = PietyAppBlocObserver();

  runApp(const PietyApp());
}
