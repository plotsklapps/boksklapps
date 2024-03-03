import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/providers/displayname_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetDisplayName extends ConsumerStatefulWidget {
  const BottomSheetDisplayName({
    super.key,
  });

  @override
  ConsumerState<BottomSheetDisplayName> createState() {
    return BottomSheetDisplayNameState();
  }
}

class BottomSheetDisplayNameState
    extends ConsumerState<BottomSheetDisplayName> {
  final GlobalKey<FormState> _displayNameFormKey = GlobalKey<FormState>();

  String? _displayName;

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
              key: _displayNameFormKey,
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
                      _displayName = value?.trim();
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
    final FormState? usernameForm = _displayNameFormKey.currentState;

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Validate the form and save the values.
    if (usernameForm!.validate()) {
      usernameForm.save();

      try {
        // Update the displayName via the provider.
        await ref.read(displayNameProvider.notifier).setDisplayName(
              _displayName!,
            );

        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Pop the bottomsheet.
        if (mounted) {
          Navigator.pop(context);
        }

        // Show a SnackBar to the user.
        CustomSnackBars.showSuccess(
          ref,
          ' You have successfully changed your username, $_displayName',
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
    } else {
      // Validation failed, cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }
}
