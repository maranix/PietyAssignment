part of 'login_bloc.dart';

sealed class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object?> get props => [];
}

final class SendOTP extends LogInEvent {
  const SendOTP({
    required this.phone,
  });

  final String phone;

  @override
  List<Object?> get props => [
        phone,
      ];
}

final class VerifyOTP extends LogInEvent {
  const VerifyOTP({
    required this.otp,
  });

  final String otp;

  @override
  List<Object?> get props => [
        otp,
      ];
}
