import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/obscured_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetDeleteUserConfirmation extends ConsumerStatefulWidget {
  const BottomSheetDeleteUserConfirmation({super.key});

  @override
  ConsumerState<BottomSheetDeleteUserConfirmation> createState() {
    return BottomSheetDeleteUserConfirmationState();
  }
}

class BottomSheetDeleteUserConfirmationState
    extends ConsumerState<BottomSheetDeleteUserConfirmation> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
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
                    obscureText: ref.watch(obscuredProvider),
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      icon: const SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.lock),
                      ),
                      labelText: 'Password',
                      suffixIcon: TextButton(
                        onPressed: () {
                          ref.read(obscuredProvider.notifier).setObscured(
                                isObscured: !ref.watch(obscuredProvider),
                              );
                        },
                        child: ref.watch(obscuredProvider)
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
                    // Cancel the spinner.
                    ref.read(spinnerProvider.notifier).cancelSpinner();

                    // Set the provider to default.
                    ref
                        .read(obscuredProvider.notifier)
                        .setObscured(isObscured: true);

                    // Pop the bottomsheet.
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    await _validateAndDeleteUser();
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

  Future<void> _validateAndDeleteUser() async {
    final FormState? deleteUserForm = _deleteUserFormKey.currentState;

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Validate the form and save the values.
    if (deleteUserForm!.validate()) {
      deleteUserForm.save();

      try {
        // Re-authenticate the user.
        await _firebase.currentUser!.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: _email!,
            password: _password!,
          ),
        );

        // Delete the user.
        await _firebase.currentUser!.delete();

        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Navigate to the StartScreen.
        if (mounted) {
          Navigate.toStartScreen(context);
        }

        // Show a SnackBar to the user.
        CustomSnackBars.showSuccess(
          ref,
          'Your account has been deleted. Thank you for using BOKSklapps!',
        );
      } catch (error) {
        // Log the error.
        Logger().e(error);

        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Pop the bottomsheet.
        if (mounted) {
          Navigator.pop(context);
        }

        // Show a SnackBar.
        CustomSnackBars.showError(ref, error.toString());
      }
    }
  }
}
