import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piety_assignment/firebase_options.dart';
import 'package:piety_assignment/src/app/observer.dart';
import 'package:piety_assignment/src/app/view/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = PietyAppBlocObserver();

  runApp(const PietyApp());
}
