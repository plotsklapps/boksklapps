import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/splash_screen.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetSignout extends StatefulWidget {
  const BottomSheetSignout({super.key});

  @override
  State<BottomSheetSignout> createState() {
    return BottomSheetSignoutState();
  }
}

class BottomSheetSignoutState extends State<BottomSheetSignout> {
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          0,
          8,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Are you sure you want to sign out?',
              style: TextUtils.fontL,
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
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
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (sSneakPeeker.value) {
                      // If the user is sneak peeking, just return to the
                      // Splash Screen.
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return const SplashScreen();
                          },
                        ),
                      );
                    }
                    // Sign out the user completely and return to the
                    // Splash Screen.
                    await _authService.signOut(
                      onError: _handleErrors,
                      onSuccess: _handleSuccess,
                    );
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(strokeWidth: 6)
                      : const FaIcon(FontAwesomeIcons.rightFromBracket),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleErrors(String error) {
    setState(() {
      _isLoading = false;
    });
    Logger().e('Error: $error');
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  void _handleSuccess() {
    setState(() {
      _isLoading = false;
    });
    Logger().i('User has signed out.');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return const SplashScreen();
        },
      ),
    );
  }
}
