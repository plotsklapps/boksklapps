import 'package:boksklapps/all_imports.dart';

/// Extracted method to login to Firebase with all exception handling
Future<void> loginToFirebase(
  BuildContext context,
  WidgetRef ref,
  String email,
  String password,
) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((UserCredential currentUser) async {
      await fetchFirestoreData(ref);
      Logger().i('Logging in with email: $email');
      if (context.mounted) {
        await Navigator.pushReplacementNamed(
          context,
          '/home_screen',
        );
      }
    });
  } on FirebaseAuthException catch (error) {
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
        const SnackBar(
          content: Text(
            'The app is not authorized to use Firebase '
            'Authentication',
          ),
        ),
      );
    } else if (error.code == 'credential-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The account corresponding to the emailaddress '
            'already exists with different sign-in credentials',
          ),
        ),
      );
    } else if (error.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The email address is already in use by another account',
          ),
        ),
      );
    } else if (error.code == 'internal-error') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'An internal error has occurred, please try again later',
          ),
        ),
      );
    } else if (error.code == 'invalid-argument') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'An invalid argument was provided, please try again '
            'later',
          ),
        ),
      );
    } else if (error.code == 'invalid-credential') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The credential data is malformed or has expired',
          ),
        ),
      );
    } else if (error.code == 'invalid-email') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The emailaddress is invalid or badly formatted',
          ),
        ),
      );
    } else if (error.code == 'invalid-verification-code') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The verification code is invalid or has expired',
          ),
        ),
      );
    } else if (error.code == 'invalid-verification-id') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The verification ID is invalid or has expired',
          ),
        ),
      );
    } else if (error.code == 'network-request-failed') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'A network error (such as timeout, interrupted connection '
            'or unreachable host) has occurred',
          ),
        ),
      );
    } else if (error.code == 'no-such-provider') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No such provider exists',
          ),
        ),
      );
    } else if (error.code == 'operation-not-allowed') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The given sign-in provider is disabled for this Firebase '
            'project',
          ),
        ),
      );
    } else if (error.code == 'provider-already-linked') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'User is already linked to the provider',
          ),
        ),
      );
    } else if (error.code == 'quota-exceeded') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The quota for this operation has been exceeded',
          ),
        ),
      );
    } else if (error.code == 'requires-recent-login') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'This operation is sensitive and requires recent '
            'authentication. Log in again before retrying '
            'this request',
          ),
        ),
      );
    } else if (error.code == 'too-many-requests') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'We have blocked all requests from this device due to '
            'unusual activity. Try again later',
          ),
        ),
      );
    } else if (error.code == 'user-disabled') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The user account has been disabled by an administrator',
          ),
        ),
      );
    } else if (error.code == 'user-mismatch') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The supplied credentials do not correspond to the '
            'previously signed in user',
          ),
        ),
      );
    } else if (error.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'There is no user corresponding to the given email',
          ),
        ),
      );
    } else if (error.code == 'user-token-expired') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "The user's credential is no longer valid. "
            'The user must sign in again',
          ),
        ),
      );
    } else if (error.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The password must be 6 characters long or more',
          ),
        ),
      );
    } else if (error.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong password provided for that user'),
        ),
      );
    } else {
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
