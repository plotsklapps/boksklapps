import 'dart:async';

import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/theme/flexcolors.dart';
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
  // Create an instance of StreamSubscription to be able to dispose of it
  // later.
  StreamSubscription<User?>? _authSubscription;

  @override
  void initState() {
    super.initState();
    // Run the authentication check on initialization.
    _checkAuthentication();
  }

  void _checkAuthentication() {
    // Set the StreamSubscription.
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          // User is known, go to HomeScreen.
          Navigation.navigateToHomeScreen(context);
        } else {
          // User is unknown, go to SigninScreen.
          Navigation.navigateToSigninScreen(context);
        }
      },
      onError: (Object error) {
        // Handle listen errors.
        Logger().e('Error during authentication check: $error');
      },
    );

    // The following method checks if the user is staring at a
    // CircularProgressIndicator for over 5 seconds. There's probably
    // something wrong and we want the user to know.
    Future<void>.delayed(const Duration(seconds: 5)).then((_) {
      // Check before proceeding:
      // 1. If not mounted, widget is no longer in tree, prevent context errors.
      // 2. If _authSubscription is null, it's not initialized, avoid null
      // access.
      // 3. If _authSubscription is paused, navigation occurred, skip timeout
      // logic.
      if (!mounted ||
          _authSubscription == null ||
          _authSubscription!.isPaused) {
        return;
      }

      // Stop listening to the subscription,
      _authSubscription!.cancel();
      // Navigate to SigninScreen so user can log in again.
      Navigation.navigateToSigninScreen(context);

      // Show the 'we're very sorry' message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Connection timeout. It's not you, it's us. Please try again "
            "later.",
          ),
          backgroundColor: flexSchemeLight.error,
        ),
      );
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Checking authentication...'),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
