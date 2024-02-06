import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    // Talking to Firebase to check if the user is logged in and
    // using (computed) signals to update the UI accordingly.
    sCurrentUser.value = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    await Future<void>.delayed(const Duration(milliseconds: 1000), () async {
      if (cLoggedIn.value) {
        if (cEmailVerified.value) {
          final DocumentSnapshot<Map<String, dynamic>> userDoc = await firestore
              .collection('users')
              .doc(sCurrentUser.value!.uid)
              .get();

          sLastVisitDate.value = userDoc['lastVisitDate'] as DateTime;
          sTotalWorkouts.value = userDoc['totalWorkouts'] as int;

          if (!mounted) return;
          Navigate.toHomeScreen(context);
          rootScaffoldMessengerKey.currentState!.showSnackBar(Snack.welcome);
        } else {
          Navigate.toStartScreen(context);
        }
      } else {
        Navigate.toStartScreen(context);
      }
    });
  }
}
