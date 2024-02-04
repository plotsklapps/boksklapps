import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/verify_screen.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetSignup extends StatefulWidget {
  const BottomSheetSignup({super.key});

  @override
  State<BottomSheetSignup> createState() {
    return BottomSheetSignupState();
  }
}

class BottomSheetSignupState extends State<BottomSheetSignup> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            const Text('Create BOKSklapps account', style: TextUtils.fontL),
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
            const SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              decoration:
                  const InputDecoration(label: Text('Confirm Password')),
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
                    // Create a new Firebase user.
                    await _authService.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                      onError: _handleErrors,
                      onSuccess: (UserCredential userCredential) async {
                        await _handleSuccess(
                          userCredential: userCredential,
                          email: email,
                        );
                      },
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
    Logger().e('Error: $error');
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

  Future<void> _handleSuccess({
    required UserCredential userCredential,
    required String email,
  }) async {
    Logger().i('User has created a new account.');
    await _authService.createUserDoc(
      userCredential: userCredential,
      onError: (String error) {
        Logger().e('Error: $error');
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            showCloseIcon: true,
          ),
        );
      },
      onSuccess: () {
        Logger().i('User document created successfully.');
      },
    );
    await _authService.sendEmailVerification(
      onError: (String error) {
        Logger().e('Error: $error');
        setState(() {
          _isLoading = false;
        });
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            showCloseIcon: true,
          ),
        );
      },
      onSuccess: () {
        Logger().i('Email verification sent to $email');
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) {
              return const VerifyScreen();
            },
          ),
        );
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text('User created successfully.'),
            showCloseIcon: true,
          ),
        );
      },
    );
  }
}
