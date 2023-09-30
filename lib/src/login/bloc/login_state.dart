part of 'login_bloc.dart';

enum LogInStatus {
  initial,
  sendingOTP,
  otpSent,
  verifying,
  verified,
  failed,
}

enum LogInErrorStatus {
  none,
  invalidPhoneNumber,
  invalidVerificationCode,
  invalidVerificationId,
  tooManyRequests,
  unknown,
}

final class LogInState extends Equatable {
  const LogInState({
    this.status = LogInStatus.initial,
    this.errorStatus = LogInErrorStatus.none,
    this.errorMessage = '',
    this.phoneNumber = '',
    this.verificationId = '',
    this.resendToken,
  });

  final LogInStatus status;
  final LogInErrorStatus errorStatus;
  final String errorMessage;
  final String phoneNumber;
  final String verificationId;
  final int? resendToken;

  LogInState copyWith({
    LogInStatus? status,
    LogInErrorStatus? errorStatus,
    String? errorMessage,
    String? phoneNumber,
    String? verificationId,
    int? resendToken,
  }) {
    return LogInState(
      status: status ?? this.status,
      errorStatus: errorStatus ?? this.errorStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorStatus,
        errorMessage,
        phoneNumber,
        verificationId,
        resendToken,
      ];
}
