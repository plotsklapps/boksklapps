import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetSignup extends ConsumerStatefulWidget {
  const BottomSheetSignup({super.key});

  @override
  ConsumerState<BottomSheetSignup> createState() {
    return BottomSheetSignupState();
  }
}

class BottomSheetSignupState extends ConsumerState<BottomSheetSignup> {
  // Custom authentification service for easier access to Firebase functions.
  final AuthService _authService = AuthService();

  // Validation key for the form textfields.
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  // Used for the password field to show/hide the password and simultaneously
  // adjust the corresponding TextButton.
  final Signal<bool> _isObscured = signal<bool>(true);

  // Instead of TextEditingControllers, use String variables to store the
  // email and password values via the onSaved method and the _signupFormKey.
  String? _email;
  String? _password;
  String? _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Create a BOKSklapps account'),
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
                  ).animate().fade().moveX(delay: 200.ms, begin: -32),
                  const SizedBox(height: 8),
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password needs to be at least 6 characters.';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
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
                  )
                      .animate()
                      .fade(delay: 200.ms)
                      .moveX(delay: 400.ms, begin: -32),
                  const SizedBox(height: 8),
                  TextFormField(
                    validator: (String? value) {
                      _confirmPassword = value?.trim();
                      if (_confirmPassword == null ||
                          _confirmPassword!.isEmpty ||
                          _confirmPassword!.length < 6) {
                        return 'Passwords needs to be at least 6 characters.';
                      } else if (_confirmPassword != _password) {
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
                  )
                      .animate()
                      .fade(delay: 400.ms)
                      .moveX(delay: 600.ms, begin: -32),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Cancel the spinner.
                    ref.read(spinnerProvider.notifier).cancelSpinner();
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
                  child: ref.watch(spinnerProvider),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateAndCreate() async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Validate the form and save the values.
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
      // Validation of form failed, so cancel the spinner and return;
      ref.read(spinnerProvider.notifier).cancelSpinner();
      return;
    }
  }

  void _handleErrors(String error) {
    // Log the error, cancel the spinner, pop the bottomsheet and show a
    // SnackBar with the error message to the user.
    Logger().e('Error: $error');
    ref.read(spinnerProvider.notifier).cancelSpinner();
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          'Error: $error',
          style: TextStyle(
            color: ref.watch(themeProvider.notifier).isDark
                ? flexSchemeDark.onError
                : flexSchemeLight.onError,
          ),
        ),
        showCloseIcon: true,
        backgroundColor: ref.watch(themeProvider.notifier).isDark
            ? flexSchemeDark.error
            : flexSchemeLight.error,
      ),
    );
  }

  Future<void> _handleSuccess({
    required UserCredential userCredential,
    required String email,
  }) async {
    // Log the success, make sure sneak peek == false, create a user
    // document and send an email verification.
    Logger().i('User has created a new account: $email');
    sSneakPeeker.value = false;
    await _authService.createUserDoc(
      userCredential: userCredential,
      onError: (String error) {
        // Log the error, cancel the spinner, pop the bottomsheet and show a
        // SnackBar with the error message to the user.
        Logger().e('Error: $error');
        ref.read(spinnerProvider.notifier).cancelSpinner();
        Navigator.pop(context);
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(
              'Error: $error',
              style: TextStyle(
                color: ref.watch(themeProvider.notifier).isDark
                    ? flexSchemeDark.onError
                    : flexSchemeLight.onError,
              ),
            ),
            showCloseIcon: true,
            backgroundColor: ref.watch(themeProvider.notifier).isDark
                ? flexSchemeDark.error
                : flexSchemeLight.error,
          ),
        );
      },
      onSuccess: () {
        // Just log it, do nothing.
        Logger().i('User document created successfully.');
      },
    );
    await _authService.sendEmailVerification(
      onError: (String error) {
        // Log the error, cancel the spinner, pop the bottomsheet and show a
        // SnackBar with the error message to the user.
        Logger().e('Error: $error');
        ref.read(spinnerProvider.notifier).cancelSpinner();
        Navigator.pop(context);
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(
              'Error: $error',
              style: TextStyle(
                color: ref.watch(themeProvider.notifier).isDark
                    ? flexSchemeDark.onError
                    : flexSchemeLight.onError,
              ),
            ),
            showCloseIcon: true,
            backgroundColor: ref.watch(themeProvider.notifier).isDark
                ? flexSchemeDark.error
                : flexSchemeLight.error,
          ),
        );
      },
      onSuccess: () {
        // Log the success, cancel the spinner, pop the bottomsheet,
        // navigate to the verify screen and show a SnackBar to the user.
        Logger().i('Email verification sent to $email');
        ref.read(spinnerProvider.notifier).cancelSpinner();
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
