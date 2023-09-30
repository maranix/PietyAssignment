import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piety_assignment/blocs/blocs.dart';
import 'package:piety_assignment/src/signup/signup.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final SignUpBloc _signUpBloc;
  late final GlobalKey<FormFieldState> _formKey;

  void _onNameChanged(String? value) {
    _signUpBloc.add(SignUpDetailsChanged(name: value));
  }

  String? _nameInputValidator(String? value) {
    if (value == null) {
      return 'Name field cannot be empty';
    }

    if (value.length < 3) {
      return 'Name cannot be less than 3 letters';
    }

    return null;
  }

  void _onSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      _signUpBloc.add(const SignUpDetailsSend());
    }

    // TODO: Cleanup this
    context
        .read<AuthBloc>()
        .add(AuthSuccess(user: FirebaseAuth.instance.currentUser));
  }

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormFieldState>();
    _signUpBloc = context.read<SignUpBloc>();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              key: _formKey,
              onChanged: _onNameChanged,
              validator: _nameInputValidator,
              onFieldSubmitted: (_) => _onSignUp,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          FilledButton.tonal(
            onPressed: _onSignUp,
            child: const Text('Signup'),
          )
        ],
      ),
    );
  }
}
