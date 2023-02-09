import 'package:boksklapps/all_imports.dart';

/// Shows a dialog to change the email address
/// Method takes context as parameter
void showChangeEmailDialog(BuildContext context) {
  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Change Email Address',
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Please enter your emailaddress:',
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Emailaddress',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'OK',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
