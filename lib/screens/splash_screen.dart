import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/screens/start_screen.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<void> _checkAuthentication() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000), () {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      // If user is signed in and email is verified, show the HomeScreen.
      if (currentUser != null) {
        // Change the signals to the current user's values and handle the
        // navigation accordingly.
        sCurrentUser.value = currentUser;
        if (sEmailVerified.value == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) {
                return const HomeScreen();
              },
            ),
          );
          rootScaffoldMessengerKey.currentState!.showSnackBar(
            const SnackBar(
              content: Text('Welcome back! Have a great workout!'),
              showCloseIcon: true,
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) {
                return const StartScreen();
              },
            ),
          );
        }
      } else {
        // If user is not signed in, show the StartScreen with the boxer GIF.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) {
              return const StartScreen();
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
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
}
