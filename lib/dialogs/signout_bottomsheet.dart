import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class BottomSheetSignout extends ConsumerStatefulWidget {
  const BottomSheetSignout({super.key});

  @override
  ConsumerState<BottomSheetSignout> createState() {
    return BottomSheetSignoutState();
  }
}

class BottomSheetSignoutState extends ConsumerState<BottomSheetSignout> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Are you sure you want to sign out?',
            ),
            const Divider(thickness: 2),
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
                    await _validateAndSignout();
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

  Future<void> _validateAndSignout() async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    if (ref.watch(sneakPeekProvider)) {
      // Set the sneak peek provider to false.
      await ref
          .read(sneakPeekProvider.notifier)
          .setSneakPeek(isSneakPeeker: false);

      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      if (mounted) {
        // Navigate to the StartScreen.
        Navigate.toStartScreen(context);
      }

      // Show a SnackBar.
      CustomSnackBars.showSuccess(
        ref,
        'You have been successfully signed out.',
      );
    } else {
      try {
        // Sign out the user.
        await _firebase.signOut();

        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        if (mounted) {
          // Navigate to the StartScreen.
          Navigate.toStartScreen(context);
        }

        // Show a SnackBar to the user.
        CustomSnackBars.showSuccess(
          ref,
          'You have been successfully signed out.',
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
    }
  }
}
