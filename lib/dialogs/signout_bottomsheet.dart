import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class BottomSheetSignout extends ConsumerStatefulWidget {
  const BottomSheetSignout({super.key});

  @override
  ConsumerState<BottomSheetSignout> createState() => _BottomSheetSignoutState();
}

class _BottomSheetSignoutState extends ConsumerState<BottomSheetSignout> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Are you sure you want to sign '
                  'out?',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    await _validateAndSignout(context);
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

  Future<void> _validateAndSignout(BuildContext context) async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();
    if (ref.watch(sneakPeekProvider)) {
      // If the user is sneak peeking, just return to the
      // Splash Screen. No need to sign out the user.
      await ref
          .read(sneakPeekProvider.notifier)
          .setSneakPeek(isSneakPeeker: false);
      Logger().i('User has signed out.');
      ref.read(spinnerProvider.notifier).cancelSpinner();
      if (context.mounted) {
        Navigator.pop(context);
        Navigate.toSplashScreen(context);
      }
    } else {
      // Sign out the user completely and return to the
      // Splash Screen.
      await AuthService().signOut(
        onError: _handleErrors,
        onSuccess: () {
          _handleSuccess(context);
        },
      );
    }
  }

  void _handleErrors(String error) {
    // Log the error, cancel the spinner and show a SnackBar with the
    // error message to the user.
    Logger().e('Error: $error');
    ref.read(spinnerProvider.notifier).cancelSpinner();
    CustomSnackBars.showErrorSnackBar(ref, error);
  }

  void _handleSuccess(BuildContext context) {
    // Log the success, cancel the spinner, navigate to the splashscreen
    // and show a SnackBar to the user.
    Logger().i('User has signed out.');
    ref.read(spinnerProvider.notifier).cancelSpinner();
    Navigate.toSplashScreen(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text('You have been successfully signed out.'),
        showCloseIcon: true,
      ),
    );
  }
}
