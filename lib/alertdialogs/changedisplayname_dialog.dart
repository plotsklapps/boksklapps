import 'package:boksklapps/all_imports.dart';

// Shows a dialog to change the displayName to Firebase
// Method takes context and ref as parameter to have access
// to both
Future<void> showChangeUserDisplayNameDialog(
  BuildContext context,
  WidgetRef ref,
) async {
  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController nameCtrl = TextEditingController();
      final TextEditingController passwordCtrl = TextEditingController();

      return AlertDialog(
        title: const Text(
          'Change Username',
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              StringUtils.kEnterInfo,
            ),
            const SizedBox(
              height: 8,
            ),
            // Name Textfield
            TextField(
              controller: nameCtrl,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: StringUtils.kNewUserName,
                prefixIcon: IconUtils.kAccount,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // Password Textfield
            TextField(
              controller: passwordCtrl,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              enableSuggestions: false,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: StringUtils.kLabelPassword,
                prefixIcon: IconUtils.kPassword,
              ),
            ),
          ],
        ),
        actions: <TextButton>[
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
              'Save',
            ),
            onPressed: () async {
              Logger().i(
                'Updating displayName to Firestore database...',
              );
              // Store new displayName to userDisplayName provider
              // and store to Firestore database
              await ref
                  .read(userDisplayNameProvider.notifier)
                  .updateUserDisplayName(
                    context,
                    ref,
                    nameCtrl.text,
                  )
                  .then((_) {
                // Show a snackBar and return to login screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      StringUtils.kUsernameChanged,
                    ),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  ),
                );
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      );
    },
  );
}
