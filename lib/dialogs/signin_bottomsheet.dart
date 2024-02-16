import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/dialogs/password_bottomsheet.dart';
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

class BottomSheetSignin extends StatefulWidget {
  const BottomSheetSignin({super.key});

  @override
  State<BottomSheetSignin> createState() {
    return BottomSheetSigninState();
  }
}

class BottomSheetSigninState extends State<BottomSheetSignin> {
  // Custom authentification service for easier access to Firebase functions.
  final AuthService _authService = AuthService();

  // Validation key for the form textfields.
  final GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();

  // Used for the password field to show/hide the password and simultaneously
  // adjust the corresponding TextButton.
  final Signal<bool> _isObscured = signal<bool>(true);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Sign in to your BOKSklapps account',
                  style: TextUtils.fontL,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.xmark,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Form(
              key: _signinFormKey,
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
                      // Save the password to the signal.
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
                  TextButton(
                    onPressed: () {
                      sSpinnerSignin.value = false;
                      Navigator.pop(context);
                      showModalBottomSheet<void>(
                        showDragHandle: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return const BottomSheetResetPassword();
                        },
                      );
                    },
                    child: const Text('Reset password'),
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
                    sSpinnerSignin.value = false;
                    _isObscured.value = true;
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
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

    final FormState? signinForm = _signinFormKey.currentState;
    if (signinForm!.validate()) {
      signinForm.save();

      // Log in to Firebase with the email and password.
      await _authService.signInWithEmailAndPassword(
        email: _email!,
        password: _password!,
        onError: _handleErrors,
        onSuccess: _handleSuccess,
      );
    } else {
      sSpinnerSignin.value = false;
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

  void _handleSuccess(UserCredential userCredential) {
    Logger().i('User signed in: ${userCredential.user!.email}');
    sSpinnerSignin.value = false;
    // Set sSneakPeeker to false when a user signs in.
    sSneakPeeker.value = false;
    Navigate.toHomeScreen(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text('You have signed in. Welcome to BOKSklapps!'),
        showCloseIcon: true,
      ),
    );
  }
}
