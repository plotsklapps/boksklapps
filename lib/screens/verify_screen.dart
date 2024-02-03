import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() {
    return VerifyScreenState();
  }
}

class VerifyScreenState extends State<VerifyScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('A verification email has been sent.'),
            SizedBox(height: 16),
            Text('Please check your spam folder as well.'),
            SizedBox(height: 16),
            Text('Click the button below AFTER verifying your email address.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          await authService.reload(
            onError: _handleErrors,
            onSuccess: ({
              required bool emailVerified,
            }) {
              _handleSuccess(context, emailVerified);
            },
          );
        },
        child: _isLoading
            ? const CircularProgressIndicator(strokeWidth: 6)
            : const FaIcon(FontAwesomeIcons.forwardStep),
      ),
      bottomNavigationBar: const BottomAppBar(
        height: 64,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(),
      ),
    );
  }

  void _handleErrors(String error) {
    setState(() {
      _isLoading = false;
    });
    Logger().e('Error: $error');
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  void _handleSuccess(BuildContext context, bool emailVerified) {
    setState(() {
      _isLoading = false;
    });
    if (emailVerified) {
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
          content: Text('Email has been verified. Welcome to BOKSklapps!'),
          showCloseIcon: true,
        ),
      );
    } else {
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Email is not yet verified. Please '
              'wait a minute and try again.'),
          showCloseIcon: true,
        ),
      );
    }
  }
}
