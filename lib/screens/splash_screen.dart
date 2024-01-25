import 'dart:async';

import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/screens/signin_screen.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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

  void _checkAuthentication() {
    final StreamSubscription<User?> subscription =
        FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          navigateToHomeScreen();
        } else {
          navigateToSigninScreen();
        }
      },
    );

    Future<void>.delayed(const Duration(seconds: 5)).then((_) {
      // If the subscription is paused, it means we've already navigated.
      if (subscription.isPaused) {
        return;
      }

      // Cancel the subscription since we're handling the timeout case.
      subscription.cancel();
      navigateToSigninScreen();

      // Make sure to use the current context which corresponds to the
      // visible Scaffold.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Connection timeout. It's not you, it's us. Please try again "
            'later.',
          ),
          backgroundColor: flexSchemeLight.error,
        ),
      );
    }).catchError((Object error) {
      Logger().e('Error during authentication check: $error');
    });
  }

  void navigateToSigninScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return const SigninScreen();
        },
      ),
    );
  }

  void navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return const HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
