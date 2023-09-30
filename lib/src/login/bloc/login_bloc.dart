import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance,
        super(const LogInState()) {
    on<LogInStateUpdated>(_onStateUpdated);
    on<SendOTP>(_onSendOTP);
    on<VerifyOTP>(_onVerifyOTP);
    on<LogInError>(_onError);
  }

  void _onStateUpdated(LogInStateUpdated event, Emitter<LogInState> emit) {
    emit(
      state.copyWith(
        status: event.status ?? state.status,
        phoneNumber: event.phoneNumber ?? state.phoneNumber,
        otp: event.otp ?? state.otp,
        verificationId: event.verificationId ?? state.verificationId,
        resendToken: event.resendToken ?? state.resendToken,
        user: event.user ?? state.user,
      ),
    );
  }

  Future<void> _onSendOTP(SendOTP event, Emitter<LogInState> emit) async {
    emit(state.copyWith(status: LogInStatus.sendingOTP));

    // Hardcoding the country code is not right but in this case its ok since its an assignment.
    // In a real app we should let the user choose their own country code.
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${state.phoneNumber}',
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  Future<void> _onVerifyOTP(VerifyOTP event, Emitter<LogInState> emit) async {
    emit(state.copyWith(status: LogInStatus.verifying));

    final credentials = PhoneAuthProvider.credential(
      verificationId: state.verificationId,
      smsCode: state.otp,
    );

    await _handleSignIn(credentials);
  }

  void _onError(LogInError event, Emitter<LogInState> emit) {
    state.copyWith(
      status: LogInStatus.failed,
      errorStatus: event.error,
      errorMessage: event.message,
    );
  }

  void _verificationCompleted(PhoneAuthCredential cred) async {
    await _handleSignIn(cred);
  }

  void _verificationFailed(FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') {
      add(
        const LogInError(
          error: LogInErrorStatus.invalidPhoneNumber,
          message: 'Invalid phone number',
        ),
      );
    }
    if (e.code == 'invalid-verification-code') {
      add(
        const LogInError(
          error: LogInErrorStatus.invalidVerificationCode,
          message: 'Invalid otp code',
        ),
      );
    }
    if (e.code == 'invalid-verification-id') {
      add(
        const LogInError(
          error: LogInErrorStatus.invalidVerificationId,
          message: 'Invalid verification id',
        ),
      );
      if (e.code == 'too-many-requests') {
        add(
          const LogInError(
            error: LogInErrorStatus.tooManyRequests,
            message: 'Too many requests',
          ),
        );
      }
    } else {
      add(
        const LogInError(
          error: LogInErrorStatus.unknown,
          message: 'An unknown error occured',
        ),
      );
    }
  }

  void _codeSent(String verificationId, int? resendToken) {
    add(
      LogInStateUpdated(
        status: LogInStatus.otpSent,
        verificationId: verificationId,
        resendToken: resendToken,
      ),
    );
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    add(LogInStateUpdated(verificationId: verificationId));
  }

  Future<void> _handleSignIn(AuthCredential credential) async {
    try {
      final cred = await _auth.signInWithCredential(credential);

      add(LogInStateUpdated(status: LogInStatus.verified, user: cred.user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-phone-number') {
        add(
          const LogInError(
            error: LogInErrorStatus.invalidPhoneNumber,
            message: 'Invalid phone number',
          ),
        );
      }
      if (e.code == 'invalid-verification-code') {
        add(
          const LogInError(
            error: LogInErrorStatus.invalidVerificationCode,
            message: 'Invalid otp code',
          ),
        );
      }
      if (e.code == 'invalid-verification-id') {
        add(
          const LogInError(
            error: LogInErrorStatus.invalidVerificationId,
            message: 'Invalid verification id',
          ),
        );
        if (e.code == 'too-many-requests') {
          add(
            const LogInError(
              error: LogInErrorStatus.tooManyRequests,
              message: 'Too many requests',
            ),
          );
        }
      } else {
        add(
          const LogInError(
            error: LogInErrorStatus.unknown,
            message: 'An unknown error occured',
          ),
        );
      }
    }
  }

  final FirebaseAuth _auth;
}
