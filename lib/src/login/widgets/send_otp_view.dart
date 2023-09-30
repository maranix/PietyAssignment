import 'package:flutter/material.dart';
import 'package:piety_assignment/blocs/blocs.dart';
import 'package:piety_assignment/src/login/login.dart';

class SendOTPView extends StatefulWidget {
  const SendOTPView({super.key});

  @override
  State<SendOTPView> createState() => _SendOTPViewState();
}

class _SendOTPViewState extends State<SendOTPView> {
  late final GlobalKey<FormFieldState> _formKey;
  late final LogInBloc _logInBloc;

  void _onPhoneInputChanged(String value) {
    _logInBloc.add(LogInStateUpdated(phoneNumber: value));
  }

  // TODO: Add more checks such as alphabets, special characters and etc.
  String? _phoneInputValidator(String? value) {
    if (value == null) {
      return 'Phone number cannot be empty';
    }

    if (value.length != 10) {
      return 'Phone number must be of 10 digits';
    }

    return null;
  }

  void _getOTP() {
    if (_formKey.currentState?.validate() ?? false) {
      _logInBloc.add(const SendOTP());
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
            maxLength: 10,
            keyboardType: TextInputType.phone,
            onChanged: _onPhoneInputChanged,
            validator: _phoneInputValidator,
            onFieldSubmitted: (_) => _getOTP(),
            decoration: const InputDecoration(
              hintText: 'Phone number',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        GetOTPButton(
          onPressed: _getOTP,
        )
      ],
    );
  }
}

class GetOTPButton extends StatelessWidget {
  const GetOTPButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final status =
        context.select<LogInBloc, LogInState>((bloc) => bloc.state).status;

    return switch (status) {
      LogInStatus.sendingOTP => const CircularProgressIndicator.adaptive(),
      _ => FilledButton.tonal(
          onPressed: onPressed,
          child: const Text('Get OTP'),
        ),
    };
  }
}
