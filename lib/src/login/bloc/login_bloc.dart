import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(const LogInInitial()) {
    on<SendOTP>(_onSendOTP);
    on<VerifyOTP>(_onVerifyOTP);
  }

  void _onSendOTP(SendOTP event, Emitter<LogInState> emit) {}
  void _onVerifyOTP(VerifyOTP event, Emitter<LogInState> emit) {}
}
