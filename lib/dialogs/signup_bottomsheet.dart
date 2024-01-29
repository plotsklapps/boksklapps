import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';

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

  bool isLoading = false;

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
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Create account', style: TextUtils.fontL),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(label: Text('EMAIL')),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(label: Text('PASSWORD')),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              decoration:
                  const InputDecoration(label: Text('CONFIRM PASSWORD')),
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
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final String email = _emailController.text.trim();
                    final String password = _passwordController.text.trim();
                    await _authService
                        .createUserWithEmailAndPassword(
                      email,
                      password,
                    )
                        .then((_) async {
                      await _authService.sendEmailVerification().then((_) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(context);
                        rootScaffoldMessengerKey.currentState!.showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Thanks for joining! A verification mail has been sent.'),
                            showCloseIcon: true,
                          ),
                        );
                      });
                    });
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('SIGN UP'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
