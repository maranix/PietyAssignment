part of 'signup_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

final class SignUpDetailsChanged extends SignUpEvent {
  const SignUpDetailsChanged();
}

final class SignUpDetailsSend extends SignUpEvent {
  const SignUpDetailsSend();
}
