import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/providers/email_provider.dart';
import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetSignin extends ConsumerStatefulWidget {
  const BottomSheetSignin({super.key});

  @override
  ConsumerState<BottomSheetSignin> createState() {
    return BottomSheetSigninState();
  }
}

class BottomSheetSigninState extends ConsumerState<BottomSheetSignin> {
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
                    // Save the email to the provider.
                    ref.read(emailProvider.notifier).setEmail(email);
                    // Log in to Firebase with the email and password.
                    await _authService
                        .signInWithEmailAndPassword(
                      email,
                      password,
                    )
                        .then((_) async {
                      // Reload the user to make sure the backend is
                      // refreshed.
                      await _authService.reload();
                    }).then((_) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return const HomeScreen();
                          },
                        ),
                      );
                    });
                    rootScaffoldMessengerKey.currentState!.showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Welcome to BOKSklapps! Have a great workout!',
                        ),
                        showCloseIcon: true,
                      ),
                    );
                    setState(() {
                      _isLoading = false;
                    });
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
}
