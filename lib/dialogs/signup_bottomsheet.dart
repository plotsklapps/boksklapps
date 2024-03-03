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

class BottomSheetSignup extends ConsumerStatefulWidget {
  const BottomSheetSignup({super.key});

  @override
  ConsumerState<BottomSheetSignup> createState() {
    return BottomSheetSignupState();
  }
}

class BottomSheetSignupState extends ConsumerState<BottomSheetSignup> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

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
                      } else {
                        return null;
                      }
                    },
                    onChanged: (String? value) {
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
                    obscureText: ref.watch(obscuredProvider),
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      icon: const SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.lock),
                      ),
                      labelText: 'Confirm Password',
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

                    // Set the provider back to default.
                    ref.read(obscuredProvider.notifier).setObscured(
                          isObscured: true,
                        );

                    // Pop the bottomsheet.
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    await _validateAndSignup();
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

  Future<void> _validateAndSignup() async {
    final FormState? signupForm = _signupFormKey.currentState;

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Validate the form and save the values.
    if (signupForm!.validate()) {
      signupForm.save();

      try {
        // Create a new Firebase user with the email and password.
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        // Send a verification email to the user.
        await _firebaseAuth.currentUser!.sendEmailVerification();

        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // // Set the provider back to default.
        await ref.read(obscuredProvider.notifier).setObscured(
              isObscured: true,
            );

        // Navigate to the VerifyScreen.
        if (mounted) {
          Navigate.toVerifyScreen(context);
        }

        // Show a SnackBar.
        CustomSnackBars.showSuccess(
          ref,
          'A verification email has been sent to $_email.',
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
