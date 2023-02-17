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
  if (email.isEmpty || password1.isEmpty || password2.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'There seem to be empty fields...',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
    return;
  } else if (password1.length < 8 || password2.length < 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Password 1 must be at least 8 characters',
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
    // Store the chosen username and email in their corresponding providers
    ref.read(currentDisplayNameProvider.notifier).state = username;
    ref.read(currentEmailProvider.notifier).state = email;

    await ref
        .watch(firebaseProvider)
        .createUserWithEmailAndPassword(
          email: email,
          password: password1,
        )
        .then((_) async {
      Logger().i(
        'Creating new database...',
      );
      // Update ALL data within the database with corresponding
      // data from the providers
      await updateFirestoreData(ref).then((_) async {
        Logger().i(
          'Updating displayname...',
        );
        // Update the displayName for Firebase the official way
        await ref.watch(currentUserProvider)!.updateDisplayName(
              username,
            );
      });
    });
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
  }
}
