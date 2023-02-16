import '/all_imports.dart';

/// Extracted method to register to Firebase with all exception handling
Future<void> registerToFirebase(
  BuildContext context,
  String email,
  String password1,
  String password2,
  String username,
) async {
  if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email cannot be empty'),
      ),
    );
    return;
  } else if (password1.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password cannot be empty'),
      ),
    );
    return;
  } else if (password2.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password cannot be empty'),
      ),
    );
    return;
  } else if (password1.length < 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password 1 must be at least 8 characters'),
      ),
    );
    return;
  } else if (password2.length < 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password 2 must be at least 8 characters'),
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
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password1,
    )
        .then((_) async {
      Logger().i(
        'Creating new database...',
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(<String, dynamic>{
        'userName': username,
        'userEmail': email,
        'userAge': 0,
        'userHeight': 0,
        'userWeight': 0,
        'userBMI': 0,
        'themeColor': 0,
        'themeMode': 0,
      }).then((_) async {
        Logger().i(
          'Updating username...',
        );
        await FirebaseAuth.instance.currentUser!.updateDisplayName(
          username,
        );
      });
    });
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Account and Database created'),
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
