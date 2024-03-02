import 'package:boksklapps/custom_snackbars.dart';
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

class BottomSheetDeleteUserConfirmation extends ConsumerStatefulWidget {
  const BottomSheetDeleteUserConfirmation({super.key});

  @override
  ConsumerState<BottomSheetDeleteUserConfirmation> createState() {
    return BottomSheetDeleteUserConfirmationState();
  }
}

class BottomSheetDeleteUserConfirmationState
    extends ConsumerState<BottomSheetDeleteUserConfirmation> {
  final FirebaseAuthService _authService = FirebaseAuthService();
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
                      // _isObscured signal.
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
                    await _validateAndDeleteUser(ref, context);
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

  Future<void> _validateAndDeleteUser(
    WidgetRef ref,
    BuildContext context,
  ) async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    final FormState? deleteUserForm = _deleteUserFormKey.currentState;
    if (deleteUserForm!.validate()) {
      deleteUserForm.save();

      await _authService.deleteUser(
        ref: ref,
        email: _email!,
        password: _password!,
      );

      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      if (context.mounted) {
        // Pop the bottomsheet.
        Navigator.pop(context);

        // Navigate to the StartScreen.
        Navigate.toStartScreen(context);
      }
      // Show a SnackBar to the user.
      CustomSnackBars.showSuccess(
        ref,
        'Your account has been deleted.',
      );
    }
  }
}
