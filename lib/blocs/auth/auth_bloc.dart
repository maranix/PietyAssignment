import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance,
        super(const AuthState()) {
    on<AuthSuccess>(_onSuccess);
    on<AuthFailure>(_onFailure);

    _auth.authStateChanges().listen(_handleAuthChange);
  }

  void _onSuccess(AuthSuccess event, Emitter<AuthState> emit) {
    if (event.user?.displayName == null) {
      emit(state.copyWith(status: AuthStatus.signUpInProgress));
    } else {
      emit(state.copyWith(status: AuthStatus.authenticated));
    }
  }

  void _onFailure(AuthFailure event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }

  void _handleAuthChange(User? user) {
    if (user == null) {
      add(const AuthFailure());
    } else {
      add(AuthSuccess(user: user));
    }
  }

  final FirebaseAuth _auth;
}
