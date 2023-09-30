part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthSuccess extends AuthEvent {
  const AuthSuccess({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];
}

final class AuthFailure extends AuthEvent {
  const AuthFailure();
}
