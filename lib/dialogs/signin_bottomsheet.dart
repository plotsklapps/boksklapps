import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/dialogs/password_bottomsheet.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/age_provider.dart';
import 'package:boksklapps/providers/bmi_provider.dart';
import 'package:boksklapps/providers/displayname_provider.dart';
import 'package:boksklapps/providers/email_provider.dart';
import 'package:boksklapps/providers/height_provider.dart';
import 'package:boksklapps/providers/lastvisit_provider.dart';
import 'package:boksklapps/providers/obscured_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/totalworkouts_provider.dart';
import 'package:boksklapps/providers/weight_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetSignin extends ConsumerStatefulWidget {
  const BottomSheetSignin({super.key});

  @override
  ConsumerState<BottomSheetSignin> createState() {
    return BottomSheetSigninState();
  }
}

class BottomSheetSigninState extends ConsumerState<BottomSheetSignin> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();

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
              title: 'Sign in to your BOKSklapps account',
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
                  TextButton(
                    onPressed: () {
                      // Cancel the spinner.
                      ref.read(spinnerProvider.notifier).cancelSpinner();

                      // Pop the bottomsheet.
                      Navigator.pop(context);

                      // Show the password reset bottomsheet.
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
                    await _validateAndSignin();
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

  Future<void> _validateAndSignin() async {
    final FormState? signinForm = _signinFormKey.currentState;

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Validate the form and save the values.
    if (signinForm!.validate()) {
      signinForm.save();

      try {
        // Log in to Firebase with the email and password.
        await _firebase.signInWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        // Check if email is verified.
        if (!_firebase.currentUser!.emailVerified) {
          // Cancel the spinner.
          ref.read(spinnerProvider.notifier).cancelSpinner();

          // Show a SnackBar.
          CustomSnackBars.showError(
            ref,
            'Your email has not been verified. Please check your inbox and/or spamfolder.',
          );
          return;
        } else {
          // Fetch user data from Firestore.
          await _firestore
              .collection('users')
              .doc(_firebase.currentUser!.uid)
              .get();

          // Get the email.
          await ref.read(emailProvider.notifier).getEmail();

          // Get the display name.
          await ref.read(displayNameProvider.notifier).getDisplayName();

          // Get the age.
          await ref.read(ageProvider.notifier).getAge();

          // Get the height.
          await ref.read(heightProvider.notifier).getHeight();

          // Get the weight.
          await ref.read(weightProvider.notifier).getWeight();

          // Get the BMI.
          await ref.read(bmiProvider.notifier).getBMI();

          // Get the last visit.
          await ref.read(lastVisitProvider.notifier).getLastVisit();

          // Get the total workouts.
          await ref.read(totalWorkoutsProvider.notifier).getTotalWorkouts();

          // Cancel the spinner.
          ref.read(spinnerProvider.notifier).cancelSpinner();

          if (mounted) {
            // Navigate to the HomeScreen.
            Navigate.toHomeScreen(context);
          }

          // Show a SnackBar.
          CustomSnackBars.showSuccess(
            ref,
            'You have signed in. Welcome to BOKSklapps!',
          );
        }
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
