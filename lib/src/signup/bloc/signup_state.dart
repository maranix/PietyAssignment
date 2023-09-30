part of 'signup_bloc.dart';

final class SignUpState extends Equatable {
  const SignUpState({
    this.name = '',
  });

  final String name;

  SignUpState copyWith({
    String? name,
  }) {
    return SignUpState(
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [name];
}
