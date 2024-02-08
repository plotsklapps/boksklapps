import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetSignin extends StatefulWidget {
  const BottomSheetSignin({super.key});

  @override
  State<BottomSheetSignin> createState() {
    return BottomSheetSigninState();
  }
}

class BottomSheetSigninState extends State<BottomSheetSignin> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();

  final Signal<bool> _isObscured = signal<bool>(true);

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            const Text('Sign in to BOKSklapps account', style: TextUtils.fontL),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Form(
              key: _signinFormKey,
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    sSpinnerSignin.value = false;
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: () async {
                    await _validateAndEnter();
                  },
                  // Watching a computed signal to provide the
                  // corresponding Widget.
                  child: cSpinnerSignIn.watch(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateAndEnter() async {
    sSpinnerSignin.value = true;

    if (_signinFormKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      // Log in to Firebase with the email and password.
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
        onError: _handleErrors,
        onSuccess: _handleSuccess,
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
    sSpinnerSignin.value = false;
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  void _handleSuccess(UserCredential userCredential) {
    Logger().i('User signed in: ${userCredential.user!.email}');
    sSpinnerSignin.value = false;
    // Set sSneakPeeker to false when a user signs in.
    sSneakPeeker.value = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return const HomeScreen();
        },
      ),
    );
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text('You have signed in. Welcome to BOKSklapps!'),
        showCloseIcon: true,
      ),
    );
  }
}
