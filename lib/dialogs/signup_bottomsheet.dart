import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/verify_screen.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  final Signal<bool> _isObscured = signal<bool>(true);

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
          16,
          0,
          16,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Create a BOKSklapps account', style: TextUtils.fontL),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Form(
              key: _signupFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    validator: (String? value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@') ||
                          !value.contains('.')) {
                        return 'Please enter a correct emailaddress.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(label: Text('Email')),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password needs to be at least 6 characters.';
                      }
                      return null;
                    },
                    obscureText: _isObscured.watch(context),
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: TextButton(
                        onPressed: () {
                          _isObscured.value = !_isObscured.value;
                        },
                        child: _isObscured.value
                            ? const Text('SHOW')
                            : const Text('HIDE'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPasswordController,
                    validator: (String? value) {
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
                      labelText: 'Confirm Password',
                      suffixIcon: TextButton(
                        onPressed: () {
                          _isObscured.value = !_isObscured.value;
                        },
                        child: _isObscured.value
                            ? const Text('SHOW')
                            : const Text('HIDE'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                    await _validateAndCreate();
                  },
                  // Watching a computed signal to provide the
                  // corresponding Widget.
                  child: cSpinnerSignup.watch(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateAndCreate() async {
    if (_signupFormKey.currentState!.validate()) {
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
    } else {
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            'Please check the email and password.',
            style: TextStyle(
              color: sDarkTheme.value
                  ? flexSchemeDark.onError
                  : flexSchemeLight.onError,
            ),
          ),
          showCloseIcon: true,
          backgroundColor:
              sDarkTheme.value ? flexSchemeDark.error : flexSchemeLight.error,
        ),
      );
      return;
    }
  }

  void _handleErrors(String error) {
    Logger().e('Error: $error');
    sSpinnerSignup.value = false;
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          'Error: $error',
          style: TextStyle(
            color: sDarkTheme.value
                ? flexSchemeDark.onError
                : flexSchemeLight.onError,
          ),
        ),
        showCloseIcon: true,
        backgroundColor:
            sDarkTheme.value ? flexSchemeDark.error : flexSchemeLight.error,
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
