import 'package:boksklapps/all_imports.dart';

// Shows a dialog to change the email address to Firebase
// Method takes context and ref as parameter to have access
// to both
Future<void> showChangeEmailDialog(
  BuildContext context,
  WidgetRef ref,
) async {
  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController email1Ctrl = TextEditingController();
      final TextEditingController email2Ctrl = TextEditingController();
      final TextEditingController passwordCtrl = TextEditingController();

      return AlertDialog(
        title: const Text(
          'Change Email Address',
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
            // Old email Textfield
            TextField(
              controller: email1Ctrl,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: StringUtils.kLabelOldEmail,
                prefixIcon: IconUtils.kEmailAddress,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // New email Textfield
            TextField(
              controller: email2Ctrl,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: StringUtils.kLabelNewEmail,
                prefixIcon: IconUtils.kEmailAddress,
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
                'Reauthenticating user...',
              );
              // Reauthenticate for Firebase security reasons
              await FirebaseAuth.instance.currentUser!
                  .reauthenticateWithCredential(
                EmailAuthProvider.credential(
                  email: email1Ctrl.text,
                  password: passwordCtrl.text,
                ),
              )
                  .then((_) async {
                Logger().i(
                  'Email address changed to ${email2Ctrl.text}',
                );
                // Update userEmailProvider value and store to
                // Firestore database
                await ref.watch(userEmailProvider.notifier).updateUserEmail(
                      context,
                      ref,
                      email2Ctrl.text,
                    );
              }).then(
                (_) {
                  // Show snackbar to user and return to LoginScreen()
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        StringUtils.kEmailAddressChanged,
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
                },
              );
            },
          ),
        ],
      );
    },
  );
}
