import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
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

class BottomSheetResetPassword extends ConsumerStatefulWidget {
  const BottomSheetResetPassword({super.key});

  @override
  ConsumerState<BottomSheetResetPassword> createState() {
    return BottomSheetResetPasswordState();
  }
}

class BottomSheetResetPasswordState
    extends ConsumerState<BottomSheetResetPassword> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  String? _email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Reset your password'),
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
                  ).animate().fade().moveX(delay: 200.ms, begin: -32),
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

                    // Pop the bottomsheet.
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    await _validateAndReset();
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

  Future<void> _validateAndReset() async {
    final FormState? passwordForm = _passwordFormKey.currentState;

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Validate the form and save the values.
    if (passwordForm!.validate()) {
      passwordForm.save();

      if (ref.watch(sneakPeekProvider) || _firebase.currentUser == null) {
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Pop the bottomsheet.
        if (mounted) {
          Navigator.pop(context);
        }

        // Show a SnackBar.
        CustomSnackBars.showError(
          ref,
          'Cannot change password in sneak peek mode. Please sign in first.',
        );

        return;
      }

      try {
        // Send a password reset email to the user.
        await _firebase.sendPasswordResetEmail(email: _email!);

        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Pop the bottomsheet.
        if (mounted) {
          Navigator.pop(context);
        }

        // Show a SnackBar.
        CustomSnackBars.showSuccess(
          ref,
          'A reset password email has been sent to $_email. Please check your'
          ' inbox and spam folder.',
        );
      } catch (error) {
        // Log the error to the console.
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
    } else {
      // Validation failed, cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }
}
