import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/email_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
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

class BottomSheetDeleteUserConfirmation extends ConsumerStatefulWidget {
  const BottomSheetDeleteUserConfirmation({super.key});

  @override
  ConsumerState<BottomSheetDeleteUserConfirmation> createState() {
    return BottomSheetDeleteUserConfirmationState();
  }
}

class BottomSheetDeleteUserConfirmationState
    extends ConsumerState<BottomSheetDeleteUserConfirmation> {
  final GlobalKey<FormState> _deleteUserFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Reauthenticate to delete your account',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Form(
              key: _deleteUserFormKey,
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
                  )
                      .animate()
                      .fade(delay: 200.ms)
                      .moveX(delay: 400.ms, begin: -32),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Make sure to reset the signal values to the default.
                    ref.read(spinnerProvider.notifier).cancelSpinner();
                    _isObscured.value = true;
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    await _validateAndDeleteUser(context);
                  },
                  // Watching a computed signal to provide the corresponding
                  // Widget.
                  child: ref.watch(spinnerProvider),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateAndDeleteUser(BuildContext context) async {
    // Show a spinner while the user is being deleted.
    ref.read(spinnerProvider.notifier).startSpinner();

    final FormState? deleteUserForm = _deleteUserFormKey.currentState;
    if (deleteUserForm!.validate()) {
      deleteUserForm.save();

      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();
        Navigator.pop(context);
        rootScaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(
              'User not found. Please check your credentials and try again.',
              style: TextStyle(
                color: ref.watch(themeProvider.notifier).isDark
                    ? flexSchemeDark.onError
                    : flexSchemeLight.error,
              ),
            ),
            showCloseIcon: true,
            backgroundColor: ref.watch(themeProvider.notifier).isDark
                ? flexSchemeDark.error
                : flexSchemeLight.error,
          ),
        );
      } else {
        // Reauthenticate the user with the email and password and
        // delete the user.
        await _authService.deleteUser(
          email: _email!,
          password: _password!,
          onError: (String error) {
            // Log the error, cancel the spinner, pop the bottomsheet and
            // show a snackbar to
            // the user with the error message.
            Logger().e('Error: $error');
            // Cancel the spinner.
            ref.read(spinnerProvider.notifier).cancelSpinner();
            Navigator.pop(context);
            rootScaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                content: Text(
                  error,
                  style: TextStyle(
                    color: ref.watch(themeProvider.notifier).isDark
                        ? flexSchemeDark.onError
                        : flexSchemeLight.error,
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
            // Log the success, cancel the spinner,return to
            // the startscreen and show a SnackBar to the user.
            Logger().i('User deleted successfully.');
            // Cancel the spinner.
            ref.read(spinnerProvider.notifier).cancelSpinner();
            Navigate.toStartScreen(context);
            rootScaffoldMessengerKey.currentState?.showSnackBar(
              const SnackBar(
                content: Text(
                  'User deleted successfully. Thank you for using BOKSklapps!',
                ),
                showCloseIcon: true,
              ),
            );
          },
        );
      }
    }
  }
}
