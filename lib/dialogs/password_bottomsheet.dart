import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetResetPassword extends StatefulWidget {
  const BottomSheetResetPassword({super.key});

  @override
  State<BottomSheetResetPassword> createState() {
    return BottomSheetResetPasswordState();
  }
}

class BottomSheetResetPasswordState extends State<BottomSheetResetPassword> {
  // Custom authentification service for easier access to Firebase functions.
  final AuthService _authService = AuthService();

  // Validation key for the form textfields.
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  String? _email;

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
            const Text('Reset password', style: TextUtils.fontL),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Form(
              key: _passwordFormKey,
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
                    sSpinnerPassword.value = false;
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    await _validateAndReset();
                  },
                  // Watching a computed signal to provide the
                  // corresponding Widget.
                  child: cSpinnerPassword.watch(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateAndReset() async {
    sSpinnerPassword.value = true;

    final FormState? passwordForm = _passwordFormKey.currentState;
    if (passwordForm!.validate()) {
      // Send a password reset email to the user.
      await _authService.sendPasswordResetEmail(
        email: _email!,
        onError: _handleErrors,
        onSuccess: _handleSuccess,
      );
    } else {
      sSpinnerPassword.value = false;
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            'Please check the emailaddress.',
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
    sSpinnerPassword.value = false;
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

  void _handleSuccess() {
    Logger().i('Reset password email sent.');
    sSpinnerPassword.value = false;
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text('A reset password email has been sent.'),
        showCloseIcon: true,
      ),
    );
  }
}
