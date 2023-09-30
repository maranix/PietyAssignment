part of 'login_bloc.dart';

enum LogInStatus {
  initial,
  sendingOTP,
  otpSent,
  verifyOTP,
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
    this.otp = '',
    this.verificationId = '',
    this.resendToken,
    this.user,
  });

  final LogInStatus status;
  final LogInErrorStatus errorStatus;
  final String errorMessage;
  final String phoneNumber;
  final String otp;
  final String verificationId;
  final int? resendToken;
  final User? user;

  LogInState copyWith({
    LogInStatus? status,
    LogInErrorStatus? errorStatus,
    String? errorMessage,
    String? phoneNumber,
    String? otp,
    String? verificationId,
    int? resendToken,
    User? user,
  }) {
    return LogInState(
      status: status ?? this.status,
      errorStatus: errorStatus ?? this.errorStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorStatus,
        errorMessage,
        phoneNumber,
        otp,
        verificationId,
        resendToken,
        user,
      ];
}
