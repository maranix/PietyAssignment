import 'package:flutter/material.dart';
import 'package:piety_assignment/blocs/blocs.dart';
import 'package:piety_assignment/src/login/login.dart';

class VerifyOTPView extends StatefulWidget {
  const VerifyOTPView({super.key});

  @override
  State<VerifyOTPView> createState() => _VerifyOTPViewState();
}

class _VerifyOTPViewState extends State<VerifyOTPView> {
  late final GlobalKey<FormFieldState> _formKey;
  late final LogInBloc _logInBloc;

  void _onOTPInputChanged(String value) {
    _logInBloc.add(LogInStateUpdated(otp: value));
  }

  // TODO: Add more checks such as alphabets, special characters and etc.
  String? _otpInputValidator(String? value) {
    if (value == null) {
      return 'Phone number cannot be empty';
    }

    if (value.length != 6) {
      return 'OTP must be of 6 digits';
    }

    return null;
  }

  void _verifyOTP() {
    if (_formKey.currentState?.validate() ?? false) {
      _logInBloc.add(const VerifyOTP());
    }
  }

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormFieldState>();
    _logInBloc = context.read<LogInBloc>();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            key: _formKey,
            maxLength: 6,
            keyboardType: TextInputType.phone,
            onChanged: _onOTPInputChanged,
            validator: _otpInputValidator,
            onFieldSubmitted: (_) => _verifyOTP(),
            decoration: const InputDecoration(
              hintText: 'OTP',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        VerifyOTPButton(
          onPressed: _verifyOTP,
        )
      ],
    );
  }
}

class VerifyOTPButton extends StatelessWidget {
  const VerifyOTPButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final status =
        context.select<LogInBloc, LogInState>((bloc) => bloc.state).status;

    return switch (status) {
      LogInStatus.verifying => const CircularProgressIndicator.adaptive(),
      _ => FilledButton.tonal(
          onPressed: onPressed,
          child: const Text('Verify OTP'),
        ),
    };
  }
}
