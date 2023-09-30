import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance,
        super(const SignUpState()) {
    on<SignUpDetailsChanged>(_onDetailsChanged);
    on<SignUpDetailsSend>(_onDetailsSend);
  }

  void _onDetailsChanged(
      SignUpDetailsChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(name: event.name ?? state.name));
  }

  void _onDetailsSend(
      SignUpDetailsSend event, Emitter<SignUpState> emit) async {
    await _auth.currentUser?.updateDisplayName(state.name);
  }

  final FirebaseAuth _auth;
}
