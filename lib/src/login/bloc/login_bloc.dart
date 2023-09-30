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
        verificationId: event.verificationId ?? state.verificationId,
        resendToken: event.resendToken ?? state.resendToken,
      ),
    );
  }

  Future<void> _onSendOTP(SendOTP event, Emitter<LogInState> emit) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: state.phoneNumber,
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  Future<void> _onVerifyOTP(VerifyOTP event, Emitter<LogInState> emit) async {
    final credentials = PhoneAuthProvider.credential(
      verificationId: state.verificationId,
      smsCode: event.otp,
    );

    await _handleSignIn(credentials);
  }

  void _onError(LogInError event, Emitter<LogInState> emit) {
    state.copyWith(
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
    add(LogInStateUpdated(
        verificationId: verificationId, resendToken: resendToken));
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    add(LogInStateUpdated(verificationId: verificationId));
  }

  Future<void> _handleSignIn(AuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);

      add(const LogInStateUpdated(status: LogInStatus.verified));
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
