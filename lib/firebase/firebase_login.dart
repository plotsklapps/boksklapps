import 'package:boksklapps/all_imports.dart';

/// Method to login to Firebase with all exception handling
Future<void> loginToFirebase(
  BuildContext context,
  WidgetRef ref,
  String email,
  String password,
) async {
  try {
    // Call Firebase method to signIn() user
    await ref
        .watch(firebaseProvider)
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((_) async {
      // If login was successful, go to HomeScreen()
      Logger().i('Logging in with email: $email');
      await Navigator.pushReplacementNamed(
        context,
        '/home_screen',
      );
    });
  }
  // Catch all FirebaseExceptions and show snackbars to user
  on FirebaseAuthException catch (error) {
    if (error.code == 'account-exists-with-different-credential') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'An account already exists with the same emailaddress,'
            ' but different sign-in credentials',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'app-not-authorized') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The app is not authorized to use Firebase '
            'Authentication',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'credential-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The account corresponding to the emailaddress '
            'already exists with different sign-in credentials',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The email address is already in use by another account',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'internal-error') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'An internal error has occurred, please try again later',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'invalid-argument') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'An invalid argument was provided, please try again '
            'later',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'invalid-credential') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The credential data is malformed or has expired',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'invalid-email') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The emailaddress is invalid or badly formatted',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'invalid-verification-code') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The verification code is invalid or has expired',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'invalid-verification-id') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The verification ID is invalid or has expired',
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
    } else if (error.code == 'no-such-provider') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'No such provider exists',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'operation-not-allowed') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The given sign-in provider is disabled for this Firebase '
            'project',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'provider-already-linked') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'User is already linked to the provider',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'quota-exceeded') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The quota for this operation has been exceeded',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'requires-recent-login') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'This operation is sensitive and requires recent '
            'authentication. Log in again before retrying '
            'this request',
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
    } else if (error.code == 'user-disabled') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The user account has been disabled by an administrator',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'user-mismatch') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The supplied credentials do not correspond to the '
            'previously signed in user',
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
            'There is no user corresponding to the given email',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'user-token-expired') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "The user's credential is no longer valid. "
            'The user must sign in again',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'The password must be 6 characters long or more',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else if (error.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Wrong password provided for that user',
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
          'Unexpected error: $error',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}
