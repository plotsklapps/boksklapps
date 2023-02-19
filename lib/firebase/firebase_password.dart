import 'package:boksklapps/all_imports.dart';

/// Extracted method to reset password with Firebase with all exception handling
Future<void> resetPassword(
  BuildContext context,
  WidgetRef ref,
  String email,
) async {
  try {
    // Check is email is empty
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'There seem to be empty fields, or email is invalid...',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
    // Firebase method to send a reset email to user
    await FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: email,
    )
        .then((_) {
      // Show snackbar to user and return to LoginScreen()
      Logger().i(
        'Reset email sent to $email',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reset email sent to $email...',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
      Navigator.pushReplacementNamed(
        context,
        '/login_screen',
      );
    });
  }
  // Catch all FirebaseExceptions and show snackbar to user
  on FirebaseAuthException catch (error) {
    if (error.code == 'invalid-email') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please check emailaddress spelling...',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'network-request-failed') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'A network error (such as timeout, interrupted connection '
            'or unreachable host) has occurred',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'too-many-requests') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'We have blocked all requests from this device due to '
            'unusual activity. Try again later',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'No user found for that emailaddress...',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else {
      Logger().i(
        'Something went wrong... $error',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unexpected error: $error',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
  } catch (error) {
    Logger().i(
      'Something went wrong... $error',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Something went wrong... $error',
        ),
      ),
    );
  }
}
