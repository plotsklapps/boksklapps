import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetEmail extends ConsumerStatefulWidget {
  const BottomSheetEmail({
    super.key,
  });

  @override
  ConsumerState<BottomSheetEmail> createState() {
    return BottomSheetEmailState();
  }
}

class BottomSheetEmailState extends ConsumerState<BottomSheetEmail> {
  // Custom authentification service for easier access to Firebase functions.
  final AuthService _authService = AuthService();

  // Validation key for the form textfields.
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

  // Instead of a TextEditingController, use a String variable to store the
  // email value via the onSaved method and the _emailFormKey.
  String? _email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Change your email address'),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Form(
              key: _emailFormKey,
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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Cancel the spinner.
                          ref.read(spinnerProvider.notifier).cancelSpinner();
                          // Pop the bottomsheet.
                          Navigator.pop(context);
                        },
                        child: const Text('CANCEL'),
                      ),
                      const SizedBox(width: 8),
                      FloatingActionButton(
                        onPressed: () async {
                          await _validateAndSetEmail();
                        },
                        // Watching a computed signal to provide the
                        // corresponding Widget.
                        child: ref.watch(spinnerProvider),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateAndSetEmail() async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Validate the form and save the values.
    final FormState? emailForm = _emailFormKey.currentState;
    if (emailForm!.validate()) {
      emailForm.save();

      // Send a email change request email to the user.
      await _authService.setEmail(
        newEmail: _email!,
        onError: _handleErrors,
        onSuccess: _handleSuccess,
      );
    } else {
      // Validation of form failed, so cancel the spinner and return.
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

  void _handleSuccess() {
    // Log the success, cancel the spinner, pop the bottomsheet and show a
    // SnackBar to the user.
    Logger().i('User has changed their email.');
    ref.read(spinnerProvider.notifier).cancelSpinner();
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text(
          'Please check your email to complete the process.',
        ),
        showCloseIcon: true,
      ),
    );
  }
}
