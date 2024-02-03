import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetSignin extends StatefulWidget {
  const BottomSheetSignin({super.key});

  @override
  State<BottomSheetSignin> createState() {
    return BottomSheetSigninState();
  }
}

class BottomSheetSigninState extends State<BottomSheetSignin> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          0,
          8,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Sign in to BOKSklapps account', style: TextUtils.fontL),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(label: Text('Email')),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(label: Text('Password')),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    final String email = _emailController.text.trim();
                    final String password = _passwordController.text.trim();
                    // Log in to Firebase with the email and password.
                    await _authService.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                      onError: _handleErrors,
                      onSuccess: _handleSuccess,
                    );
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(strokeWidth: 6)
                      : const FaIcon(FontAwesomeIcons.forwardStep),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleErrors(String error) {
    setState(() {
      _isLoading = false;
    });
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  void _handleSuccess(UserCredential userCredential) {
    setState(() {
      _isLoading = false;
    });
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
        content: Text('You have signed in. Welcome to BOKSklapps!'),
        showCloseIcon: true,
      ),
    );
  }
}
