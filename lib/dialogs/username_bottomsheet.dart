import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetUsername extends ConsumerStatefulWidget {
  const BottomSheetUsername({
    super.key,
  });

  @override
  ConsumerState<BottomSheetUsername> createState() {
    return BottomSheetUsernameState();
  }
}

class BottomSheetUsernameState extends ConsumerState<BottomSheetUsername> {
  // Custom authentification service for easier access to Firebase functions.
  final AuthService _authService = AuthService();

  // Validation key for the form textfields.
  final GlobalKey<FormState> _usernameFormKey = GlobalKey<FormState>();

  // Instead of a TextEditingController, use a String variable to store the
  // username value via the onSaved method and the _usernameFormKey.
  String? _username;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Change how we call you'),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Form(
              key: _usernameFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username.';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? value) {
                      _username = value?.trim();
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.fileSignature),
                      ),
                      labelText: 'Username',
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
                          await _validateAndSetDisplayName();
                        },
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

  Future<void> _validateAndSetDisplayName() async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();
    // Validate the form and save the values.
    final FormState? usernameForm = _usernameFormKey.currentState;
    if (usernameForm!.validate()) {
      usernameForm.save();

      // Use Firebase to change the displayName of the user.
      await _authService.setDisplayName(
        newDisplayName: _username!,
        onError: _handleErrors,
        onSuccess: _handleSuccess,
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

  void _handleSuccess() {
    // Log the success, cancel the spinner, pop the bottomsheet and show a
    // SnackBar to the user.
    Logger().i('User has changed their displayName.');
    ref.read(spinnerProvider.notifier).cancelSpinner();
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text(
          'You have successfully changed your username.',
        ),
        showCloseIcon: true,
      ),
    );
  }
}
