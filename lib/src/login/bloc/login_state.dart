part of 'login_bloc.dart';

sealed class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object?> get props => [];
}

final class LogInInitial extends LogInState {
  const LogInInitial();
}
