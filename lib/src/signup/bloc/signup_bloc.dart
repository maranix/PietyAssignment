import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpDetailsChanged>(_onDetailsChanged);
    on<SignUpDetailsSend>(_onDetailsSend);
  }

  void _onDetailsChanged(SignUpDetailsChanged event, Emitter<SignUpState> emit) {}
  void _onDetailsSend(SignUpDetailsSend event, Emitter<SignUpState> emit) {}
}
