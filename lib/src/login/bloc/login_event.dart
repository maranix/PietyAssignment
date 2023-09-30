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
    this.otp,
    this.verificationId,
    this.resendToken,
    this.user,
  });

  final LogInStatus? status;
  final String? phoneNumber;
  final String? otp;
  final String? verificationId;
  final int? resendToken;
  final User? user;

  @override
  List<Object?> get props => [
        status,
        phoneNumber,
        otp,
        verificationId,
        resendToken,
        user,
      ];
}

final class SendOTP extends LogInEvent {
  const SendOTP();
}

final class VerifyOTP extends LogInEvent {
  const VerifyOTP();
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
