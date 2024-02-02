import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/screens/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This SplashScreen merely exists to show a CircularProgressIndicator
// while the Firebase services are loading and checking for an existing
// user. If an existing use is NOT found, the user will always sign in
// anonymously and create an corresponding Firebase account later in-app.

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000), () {
      // Check if user is signed in (non-anonymously).
      final User? currentUser = FirebaseAuth.instance.currentUser;
      // If user is signed in, navigate to home screen and show snackbar.
      if (currentUser != null) {
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
            content: Text('Have a great workout!'),
            showCloseIcon: true,
          ),
        );
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
