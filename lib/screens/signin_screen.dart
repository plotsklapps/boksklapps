import 'package:boksklapps/screens/home_screen.dart';
import 'package:boksklapps/screens/password_screen.dart';
import 'package:boksklapps/screens/signup_screen.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() {
    return SigninScreenState();
  }
}

class SigninScreenState extends State<SigninScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                enableSuggestions: false,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) {
                        return const SignupScreen();
                      },
                    ),
                  );
                },
                child: const Text(
                  'New here? Sign up!',
                  style: TextUtils.fontL,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) {
                        return const PasswordScreen();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Forgot password?',
                  style: TextUtils.fontL,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Sneak Peek',
                  style: TextUtils.fontL,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) {
                return const HomeScreen();
              },
            ),
          );
        },
        child: const FaIcon(FontAwesomeIcons.forwardStep),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomAppBar(
        height: 64,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Text(
          'SIGN IN',
          style: TextUtils.fontXL,
        ),
      ),
    );
  }
}
