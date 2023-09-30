part of 'signup_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

final class SignUpDetailsChanged extends SignUpEvent {
  const SignUpDetailsChanged({
    this.name,
  });

  final String? name;

  @override
  List<Object?> get props => [name];
}

final class SignUpDetailsSend extends SignUpEvent {
  const SignUpDetailsSend();
}
