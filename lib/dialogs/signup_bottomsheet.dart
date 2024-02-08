import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/verify_screen.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetSignup extends StatefulWidget {
  const BottomSheetSignup({super.key});

  @override
  State<BottomSheetSignup> createState() {
    return BottomSheetSignupState();
  }
}

class BottomSheetSignupState extends State<BottomSheetSignup> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final AuthService _authService = AuthService();

  Signal<bool> _isObscured = signal<bool>(true);

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          0,
          8,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Create BOKSklapps account', style: TextUtils.fontL),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            const SignupForm(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: () async {
                    sSpinnerSignup.value = true;
                    final String email = _emailController.text.trim();
                    final String password = _passwordController.text.trim();
                    // Create a new Firebase user.
                    await _authService.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                      onError: _handleErrors,
                      onSuccess: (UserCredential userCredential) async {
                        await _handleSuccess(
                          userCredential: userCredential,
                          email: email,
                        );
                      },
                    );
                  },
                  // Watching a computed signal to provide the
                  // corresponding Widget.
                  child: cSpinnerSignup.value,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleErrors(String error) {
    Logger().e('Error: $error');
    sSpinnerSignup.value = false;
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  Future<void> _handleSuccess({
    required UserCredential userCredential,
    required String email,
  }) async {
    Logger().i('User has created a new account.');
    await _authService.createUserDoc(
      userCredential: userCredential,
      onError: (String error) {
        Logger().e('Error: $error');
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            showCloseIcon: true,
          ),
        );
      },
      onSuccess: () {
        Logger().i('User document created successfully.');
      },
    );
    await _authService.sendEmailVerification(
      onError: (String error) {
        Logger().e('Error: $error');
        sSpinnerSignup.value = false;
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            showCloseIcon: true,
          ),
        );
      },
      onSuccess: () {
        Logger().i('Email verification sent to $email');
        sSpinnerSignup.value = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) {
              return const VerifyScreen();
            },
          ),
        );
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text('User created successfully.'),
            showCloseIcon: true,
          ),
        );
      },
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmPasswordFormKey = GlobalKey<FormState>();

  Signal<bool> _isObscured = signal<bool>(false);

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            key: _emailFormKey,
            validator: (String? value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Please enter a correct emailaddress.';
              } else {
                return null;
              }
            },
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(label: Text('Email')),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            key: _passwordFormKey,
            validator: (String? value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return 'Password needs to be at least 6 characters.';
              } else {
                return null;
              }
            },
            obscureText: _isObscured.watch(context),
            enableSuggestions: false,
            decoration: InputDecoration(
              label: const Text('Password'),
              suffixIcon: _isObscured.watch(context)
                  ? GestureDetector(
                      onTap: () {
                        _isObscured.value = false;
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.eye,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _isObscured.value = true;
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.eyeSlash,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordController,
            key: _confirmPasswordFormKey,
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return 'Passwords needs to be at least 6 characters.';
              } else if (value != _passwordController.text) {
                return 'Passwords do not appear to be equal.';
              } else {
                return null;
              }
            },
            obscureText: _isObscured.watch(context),
            enableSuggestions: false,
            decoration: InputDecoration(
              label: const Text('Confirm Password'),
              suffixIcon: _isObscured.watch(context)
                  ? GestureDetector(
                      onTap: () {
                        _isObscured.value = false;
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.eye,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _isObscured.value = true;
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.eyeSlash,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
