import 'package:boksklapps/all_imports.dart';

/// Extracted method to register to Firebase with all exception handling
Future<void> registerToFirebase(
  BuildContext context,
  WidgetRef ref,
  String email,
  String password1,
  String password2,
  String username,
) async {
  if (email.isEmpty ||
      !email.contains('@') ||
      password1.isEmpty ||
      password2.isEmpty) {
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
    return;
  } else if (password1.length < 6 || password2.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Password must be at least 6 characters',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
    return;
  } else if (password1 != password2) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passwords do not match'),
      ),
    );
  } else {
    Logger().i(
      'Registering new account...',
    );
    await ref
        .watch(firebaseProvider)
        .createUserWithEmailAndPassword(
          email: email,
          password: password1,
        )
        .then((_) async {
      Logger().i(
        'Updating displayname...',
      );
      // Update the displayName for Firebase the official way
      await ref
          .watch(firebaseProvider)
          .currentUser!
          .updateDisplayName(
            username,
          )
          .then((_) async {
        Logger().i(
          'Creating new database...',
        );
        // Update ALL data within the database with corresponding
        // data from the providers
        await updateFirestoreData(ref);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Account and Database created... Thank you for joining! '
                'Please log in now.',
              ),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
        }
        if (context.mounted) {
          await Navigator.pushReplacementNamed(
            context,
            '/login_screen',
          );
        }
      });
    });
  }
}
