import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Navigation {
  static void navigateToSplashScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return const SplashScreen();
        },
      ),
    );
  }

  static void navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return const HomeScreen();
        },
      ),
    );
  }
}
