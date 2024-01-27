import 'dart:async';

import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

// This SplashScreen merely exists to show a CircularProgressIndicator
// while the Firebase services are loading and checking for an existing
// user. If an existing use is NOT found, the user will always sign in
// anonymously and create an corresponding Firebase account later in-app.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();
  StreamSubscription<User?>? _authSubscription;
  bool _isAuthenticated = false;
  bool _isSigningIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() {
    setState(() {
      _isAuthenticated = true;
      _isSigningIn = true;
    });
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          Navigation.navigateToHomeScreen(context);
        } else {
          setState(() {
            _isAuthenticated = false;
            _isSigningIn = false;
          });
        }
      },
      onError: (Object error) {
        Logger().e('Error during authentication check: $error');
      },
    );
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_isAuthenticated)
                const Text(
                  'Checking authentication...',
                  style: TextUtils.fontL,
                )
              else
                const Text(
                  'Welcome to BOKSklapps',
                  style: TextUtils.fontL,
                ),
              const SizedBox(height: 24),
              if (_isAuthenticated)
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                  ),
                )
              else
                Image.asset(
                  'assets/GIF/littleBoxer.gif',
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: _isSigningIn
          ? const CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isSigningIn = true;
                });
                _authService.signInAnonymously().then((_) {
                  setState(() {
                    _isAuthenticated = true;
                  });
                  return Navigation.navigateToHomeScreen(context);
                }).onError((Object error, StackTrace stackTrace) {
                  setState(() {
                    _isSigningIn = false;
                  });
                  Logger().e('Error during anonymous sign in: $error');
                  rootScaffoldMessengerKey.currentState!.showSnackBar(
                    SnackBar(
                      content:
                          const Text('Something went wrong! Please try again.'),
                      backgroundColor: flexSchemeLight.error,
                    ),
                  );
                  return null;
                });
              },
              child: _isSigningIn
                  ? const CircularProgressIndicator()
                  : const FaIcon(FontAwesomeIcons.forwardStep),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomBar(),
    );
  }
}
