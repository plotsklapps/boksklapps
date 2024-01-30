import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/providers/email_provider.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetSignup extends ConsumerStatefulWidget {
  const BottomSheetSignup({super.key});

  @override
  ConsumerState<BottomSheetSignup> createState() {
    return BottomSheetSignupState();
  }
}

class BottomSheetSignupState extends ConsumerState<BottomSheetSignup> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final AuthService _firebaseAuth = AuthService();

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
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
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
                    // Save the email to the provider.
                    ref.read(emailProvider.notifier).setEmail(email);
                    // Send the sign in link to the email.
                    await _firebaseAuth.createUserWithEmailAndPassword(
                      email,
                      password,
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
}
