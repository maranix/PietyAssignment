import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthInitial>(_onInitial);
    on<AuthSuccess>(_onSuccess);
    on<AuthFailure>(_onFailure);
  }

  void _onInitial(AuthInitial event, Emitter<AuthState> emit) {}
  void _onSuccess(AuthSuccess event, Emitter<AuthState> emit) {}
  void _onFailure(AuthFailure event, Emitter<AuthState> emit) {}
}
