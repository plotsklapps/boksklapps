import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetDeleteUser extends StatelessWidget {
  const BottomSheetDeleteUser({super.key});

  @override
  Widget build(BuildContext context) {
    final Computed<Widget> cShowSpinner = computed(() {
      return sShowSpinner.value
          ? CircularProgressIndicator(
              strokeWidth: 6,
              color: sDarkTheme.value
                  ? flexSchemeDark.onError
                  : flexSchemeLight.onError,
            )
          : FaIcon(
              FontAwesomeIcons.solidTrashCan,
              color: sDarkTheme.value
                  ? flexSchemeDark.onError
                  : flexSchemeLight.onError,
            );
    });
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Delete your account'),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            const Text(
              'Are you sure you want to delete your account? This action is '
              'irreversible and will delete all your data.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    sShowSpinner.value = false;
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    _validateAndDeleteUser(context);
                  },
                  backgroundColor: sDarkTheme.value
                      ? flexSchemeDark.error
                      : flexSchemeLight.error,
                  child: cShowSpinner.watch(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndDeleteUser(BuildContext context) {
    // Show a spinner while the user is being deleted.
    sShowSpinner.value = true;

    if (sSneakPeeker.value) {
      // Cancel the spinner, pop the bottomsheet and show a
      // SnackBar to the user.
      sShowSpinner.value = false;
      Navigator.pop(context);
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            'You are a sneak peeker and therefore cannot '
            'delete an account that does not exist.',
            style: TextStyle(
              color: sDarkTheme.value
                  ? flexSchemeDark.onError
                  : flexSchemeLight.onError,
            ),
          ),
          showCloseIcon: true,
          backgroundColor:
              sDarkTheme.value ? flexSchemeDark.error : flexSchemeLight.error,
        ),
      );
    } else {
      AuthService().deleteUser(
        onError: (String error) {
          // Log the error, cancel the spinner and show a SnackBar
          // with the error message to the user.
          Logger().e('Error: $error');
          sShowSpinner.value = false;
          rootScaffoldMessengerKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(
                'Error: $error',
                style: TextStyle(
                  color: sDarkTheme.value
                      ? flexSchemeDark.onError
                      : flexSchemeLight.onError,
                ),
              ),
              showCloseIcon: true,
              backgroundColor: sDarkTheme.value
                  ? flexSchemeDark.error
                  : flexSchemeLight.error,
            ),
          );
        },
        onSuccess: () {
          // Log the success, cancel the spinner, pop the bottomsheet,
          // return to the StartScreen and show a SnackBar to the user.
          Logger().i('User deleted forever.');
          sShowSpinner.value = false;
          Navigator.pop(context);
          Navigate.toStartScreen(context);
          rootScaffoldMessengerKey.currentState!.showSnackBar(
            const SnackBar(
              content: Text('Your account has been deleted. Thank you '
                  'for trying BOKSklapps!'),
              showCloseIcon: true,
            ),
          );
        },
      );
    }
  }
}
