import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class Navigation {
  static void navigateToSigninScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return const SigninScreen();
        },
      ),
    );
  }

  static void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return const HomeScreen();
        },
      ),
    );
  }
}
