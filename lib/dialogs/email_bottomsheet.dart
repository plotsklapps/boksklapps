import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final FirebaseAuthService _authService = FirebaseAuthService();

  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

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
                      labelText: 'New Email',
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
                          await _validateAndSetEmail(context, ref);
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

  Future<void> _validateAndSetEmail(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    final FormState? emailUserForm = _emailFormKey.currentState;
    if (emailUserForm!.validate()) {
      emailUserForm.save();

      await _authService.updateEmail(
        ref: ref,
        email: _email!,
      );

      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      if (context.mounted) {
        // Pop the bottomsheet.
        Navigator.pop(context);

        // Navigate to the StartScreen.
        Navigate.toVerifyScreen(context);
      }
      // Show a SnackBar to the user.
      CustomSnackBars.showSuccessSnackBar(
        ref,
        'Please check your email to verify your new email address.',
      );
    }
  }
}
