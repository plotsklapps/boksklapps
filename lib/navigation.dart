import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/screens/start_screen.dart';
import 'package:boksklapps/screens/tutorial_screen.dart';
import 'package:boksklapps/screens/tutorialworkout_screen.dart';
import 'package:boksklapps/screens/verify_screen.dart';
import 'package:flutter/material.dart';

// Creating a class dedicated to navigational Strings to
// avoid typo's.
class NavString {
  static String startScreen = '/startScreen';
  static String verifyScreen = '/verifyScreen';
  static String homeScreen = '/homeScreen';
  static String tutorialScreen = '/tutorialScreen';
  static String tutorialWorkoutScreen = '/tutorialWorkoutScreen';
}

// Defining routes with key-value pairs to use in the Navigate
// class.
final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  NavString.startScreen: (BuildContext context) {
    return const StartScreen();
  },
  NavString.verifyScreen: (BuildContext context) {
    return const VerifyScreen();
  },
  NavString.homeScreen: (BuildContext context) {
    return const HomeScreen();
  },
  NavString.tutorialScreen: (BuildContext context) {
    return const TutorialScreen();
  },
  NavString.tutorialWorkoutScreen: (BuildContext context) {
    return const TutorialWorkoutScreen();
  },
};

// Creating a more convenient way of navigating inside the app.
// Use simply as Navigate.toSplashScreen(context); for example.
class Navigate {
  static void toStartScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, NavString.startScreen);
  }

  static void toVerifyScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, NavString.verifyScreen);
  }

  static void toHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, NavString.homeScreen);
  }

  static void toTutorialScreen(BuildContext context) {
    Navigator.pushNamed(context, NavString.tutorialScreen);
  }

  static void toTutorialWorkoutScreen(BuildContext context) {
    Navigator.pushNamed(context, NavString.tutorialWorkoutScreen);
  }
}
