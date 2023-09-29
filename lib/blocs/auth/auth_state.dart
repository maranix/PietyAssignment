part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  unauthenticated,
  signUpInProgress,
  authenticated,
}

final class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
  });

  final AuthStatus status;
  final User? user;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
      ];
}
