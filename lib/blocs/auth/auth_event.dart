part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthEvent {
  const AuthInitial();
}

final class AuthSuccess extends AuthEvent {
  const AuthSuccess();
}

final class AuthFailure extends AuthEvent {
  const AuthFailure();
}
