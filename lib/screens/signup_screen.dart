import 'package:boksklapps/screens/signin_screen.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

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
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                enableSuggestions: false,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Confirm '
                      'Password',
                ),
                obscureText: true,
                enableSuggestions: false,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return const SigninScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Wait, I have an account!',
                      style: TextUtils.fontL,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const FaIcon(FontAwesomeIcons.forwardStep),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomAppBar(
        height: 64,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Text(
          'SIGN UP',
          style: TextUtils.fontXL,
        ),
      ),
    );
  }
}
