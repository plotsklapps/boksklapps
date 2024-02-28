import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:boksklapps/providers/obscured_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetSignup extends ConsumerStatefulWidget {
  const BottomSheetSignup({super.key});

  @override
  ConsumerState<BottomSheetSignup> createState() {
    return BottomSheetSignupState();
  }
}

class BottomSheetSignupState extends ConsumerState<BottomSheetSignup> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Validation key for the form textfields.
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

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
                      // Store user input in local variable.
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
                      // Store user input in local variable.
                      _password = value?.trim();
                    },
                    keyboardType: TextInputType.text,
                    // Update the UI based on the provider.
                    obscureText: ref.watch(obscuredProvider),
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      icon: const SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.lock),
                      ),
                      labelText: 'Password',
                      // Instead of an icon, use a TextButton to toggle the
                      // provider.
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
                      // Store user input in local variable.
                      _confirmPassword = value?.trim();

                      // Run some checks.
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
                    // Update the UI based on the provider.
                    obscureText: ref.watch(obscuredProvider),
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      icon: const SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.lock),
                      ),
                      labelText: 'Confirm Password',
                      // Instead of an icon, use a TextButton to toggle the
                      // provider.
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
                    // Call the local _validateAndCreate method.
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
      // Inside this method a verification email will be sent as well.
      await _authService.createUserWithEmailAndPassword(
        context: context,
        ref: ref,
        email: _email!,
        password: _password!,
      );

      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      // Navigate to the verification screen.
      if (mounted) {
        Navigate.toVerifyScreen(context);
      }
    } else {
      // Validation of form failed: cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
      return;
    }
  }
}
