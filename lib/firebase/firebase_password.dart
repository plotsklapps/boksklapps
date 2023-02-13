import 'package:boksklapps/all_imports.dart';

/// Extracted method to reset password with Firebase with all exception handling
Future<void> resetPassword(BuildContext context, String email) async {
  try {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email cannot be empty, please verify your emailaddress',
          ),
        ),
      );
      return;
    }
    await FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: email,
    )
        .then((_) {
      /// Logging to console
      Logger().i(
        'Reset email sent to $email',
      );

      /// Show snackbar to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reset email sent to $email',
          ),
        ),
      );

      /// Navigate to login screen
      Navigator.pushReplacementNamed(
        context,
        '/login_screen',
      );
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    }
  }
}
