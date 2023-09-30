part of 'login_bloc.dart';

sealed class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object?> get props => [];
}

final class LogInStateUpdated extends LogInEvent {
  const LogInStateUpdated({
    this.status,
    this.phoneNumber,
    this.verificationId,
    this.resendToken,
  });

  final LogInStatus? status;
  final String? phoneNumber;
  final String? verificationId;
  final int? resendToken;

  @override
  List<Object?> get props => [
        status,
        phoneNumber,
        verificationId,
        resendToken,
      ];
}

final class SendOTP extends LogInEvent {
  const SendOTP();
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

final class LogInError extends LogInEvent {
  const LogInError({
    required this.error,
    required this.message,
  });

  final LogInErrorStatus error;
  final String message;

  @override
  List<Object?> get props => [
        error,
        message,
      ];
}
