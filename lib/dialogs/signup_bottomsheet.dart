import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/flextheme.dart';
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
  // Custom authentification service for easier access to Firebase functions.
  // See auth_service.dart for more details.
  final AuthService _authService = AuthService();

  // Validation key for the form textfields.
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  // Used for the password field to show/hide the password and simultaneously
  // adjust the corresponding TextButton.
  final Signal<bool> _isObscured = signal<bool>(true);

  //
  String? _email;
  String? _password;

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
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (String? value) {
                      final RegExp regex = RegExp(
                        TextUtils.regexpPattern as String,
                      );
                      if (!regex.hasMatch(value!)) {
                        return 'Please check the email spelling.';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? value) {
                      _email = value?.trim();
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.solidEnvelope),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password needs to be at least 6 characters.';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _password = value?.trim();
                    },
                    keyboardType: TextInputType.text,
                    // Update the UI based on the signal value.
                    obscureText: _isObscured.watch(context),
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      icon: const SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.lock),
                      ),
                      labelText: 'Password',
                      // Instead of an icon, use a TextButton to toggle the
                      // _isObscured signal.
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Passwords needs to be at least 6 characters.';
                      } else if (value != _password) {
                        return 'Passwords do not appear to be equal.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    // Update the UI based on the signal value.
                    obscureText: _isObscured.watch(context),
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      icon: const SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.lock),
                      ),
                      labelText: 'Confirm Password',
                      // Instead of an icon, use a TextButton to toggle the
                      // _isObscured signal.
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
                    // Make sure to reset the signal values to
                    // the default.
                    sSpinnerSignup.value = false;
                    _isObscured.value = true;
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
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
    sSpinnerSignup.value = true;

    final FormState? signupForm = _signupFormKey.currentState;
    if (signupForm!.validate()) {
      signupForm.save();

      // Create a new Firebase user with the email and password.
      await _authService.createUserWithEmailAndPassword(
        email: _email!,
        password: _password!,
        onError: _handleErrors,
        onSuccess: (UserCredential userCredential) async {
          await _handleSuccess(
            userCredential: userCredential,
            email: _email!,
          );
        },
      );
    } else {
      sSpinnerSignup.value = false;
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
    Navigator.pop(context);
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
    Logger().i('User has created a new account: $email');
    sSpinnerSignup.value = false;
    // Set sSneakPeeker to false when a user signs in.
    sSneakPeeker.value = false;
    await _authService.createUserDoc(
      userCredential: userCredential,
      onError: (String error) {
        Logger().e('Error: $error');
        Navigator.pop(context);
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
        Navigator.pop(context);
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            showCloseIcon: true,
          ),
        );
      },
      onSuccess: () {
        Logger().i('Email verification sent to $email');
        Navigator.pop(context);
        Navigate.toVerifyScreen(context);
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
