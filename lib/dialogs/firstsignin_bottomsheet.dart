import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/dialogs/signin_bottomsheet.dart';
import 'package:boksklapps/dialogs/signup_bottomsheet.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetFirstSignin extends ConsumerStatefulWidget {
  const BottomSheetFirstSignin({super.key});

  @override
  ConsumerState<BottomSheetFirstSignin> createState() {
    return BottomSheetFirstSigninState();
  }
}

class BottomSheetFirstSigninState
    extends ConsumerState<BottomSheetFirstSignin> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Choose an option to continue'),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            ListTile(
              onTap: () async {
                // Pop the bottomsheet.
                Navigator.pop(context);

                // Open the signup bottomsheet.
                await showModalBottomSheet<void>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetSignup();
                  },
                );
              },
              leading: const FaIcon(
                FontAwesomeIcons.userPlus,
              ),
              title: const Text('Create an account'),
              subtitle: const Text(
                'Get a personalized experience and save your statistics '
                '(recommended).',
              ),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade().moveX(delay: 200.ms, begin: -32),
            ListTile(
              onTap: () async {
                // Pop the bottomsheet.
                Navigator.pop(context);

                // Open the signin bottomsheet.
                await showModalBottomSheet<void>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetSignin();
                  },
                );
              },
              leading: const FaIcon(
                FontAwesomeIcons.userCheck,
              ),
              title: const Text('Use an existing account'),
              subtitle: const Text(
                'You already used BOKSklapps before and want to sign in again.',
              ),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms, begin: -32),
            ListTile(
              onTap: () async {
                await _continueAsSneakPeeker();
              },
              leading: const FaIcon(FontAwesomeIcons.userSecret),
              title: const Text('Sneak peek'),
              subtitle: const Text(
                'Try out BOKSklapps anonymously without storing any data.',
              ),
              // Watching a computed signal to provide the
              // corresponding Widget.
              trailing: ref.watch(spinnerProvider),
            ).animate().fade(delay: 400.ms).moveX(delay: 600.ms, begin: -32),
          ],
        ),
      ),
    );
  }

  Future<void> _continueAsSneakPeeker() async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    try {
      // Sign in the user 'anonymously'. For now, that means just setting
      // the sneakpeekprovider to true.
      await ref.read(sneakPeekProvider.notifier).setSneakPeek(
            isSneakPeeker: true,
          );

      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      // Navigate to the HomeScreen.
      if (mounted) {
        Navigate.toHomeScreen(context);
      }

      // Show a SnackBar to the user.
      CustomSnackBars.showSuccess(
        ref,
        'Welcome to BOKSklapps! You are a sneak peeker, your data will NOT be '
        'stored.',
      );
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      // Show a SnackBar.
      CustomSnackBars.showError(ref, error.toString());
    }
  }
}
