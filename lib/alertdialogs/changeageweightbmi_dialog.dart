import 'package:boksklapps/all_imports.dart';

/// Shows a dialog to change the email address
/// Method takes context as parameter
Future<void> showChangeAgeWeightBMI(BuildContext context) async {
  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'No Active Account',
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'No Account is currently active. '
              'Please sign in or create an account.',
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
            ),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Login',
            ),
            onPressed: () async {
              await Navigator.pushReplacementNamed(
                context,
                '/login_screen',
              );
            },
          ),
        ],
      );
    },
  );
}
