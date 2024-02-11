import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// This SplashScreen merely exists to show a CircularProgressIndicator
// while the Firebase services are loading and checking for an existing
// user.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 6),
        ),
      ),
    );
  }

  Future<void> _checkAuthentication() async {
    final AuthService authService = AuthService();
    // Talking to Firebase to check if the user is logged in and
    // using (computed) signals to update the UI accordingly.
    sCurrentUser.value = FirebaseAuth.instance.currentUser;

    // Delay this function to avoid initState issues.
    await Future<void>.delayed(const Duration(milliseconds: 800), () async {
      // Check if the user is logged in and if the email is verified.
      if (cLoggedIn.value) {
        if (cEmailVerified.value) {
          // Get the user document from Firestore and store the values
          // in their respective signals.
          await authService.getUserDoc(
            user: sCurrentUser.value!,
            onError: _handleErrors,
            onSuccess: _handleSuccess,
          );
        } else {
          Navigate.toStartScreen(context);
        }
      } else {
        Navigate.toStartScreen(context);
      }
    });
  }

  // Method to show the error in a snackbar to the user and
  // log it to the console.
  void _handleErrors(String error) {
    Logger().e('Error: $error');
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
        backgroundColor:
            sDarkTheme.value ? flexSchemeDark.error : flexSchemeLight.error,
      ),
    );
  }

  void _handleSuccess() {
    Navigate.toHomeScreen(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text('Welcome to BOKSklapps, enjoy your workout!'),
        showCloseIcon: true,
      ),
    );
  }
}
