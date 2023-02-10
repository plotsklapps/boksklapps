import 'package:boksklapps/all_imports.dart';

/// Shows a dialog to change the email address
/// Method takes context as parameter
Future<void> showChangeEmailDialog(BuildContext context) async {
  /// EmailController for old email
  final email1Ctrl = TextEditingController();

  /// EmailController for new email
  final email2Ctrl = TextEditingController();

  /// PasswordController
  final passwordCtrl = TextEditingController();

  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Change Email Address',
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please enter the following information:',
            ),
            const SizedBox(
              height: 8,
            ),
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
            onPressed: () async {
              await FirebaseAuth.instance.currentUser!
                  .reauthenticateWithCredential(
                EmailAuthProvider.credential(
                  email: email1Ctrl.text,
                  password: passwordCtrl.text,
                ),
              );
              await FirebaseAuth.instance.currentUser!
                  .updateEmail(email2Ctrl.text)
                  .then((_) {
                Navigator.pushReplacementNamed(
                  context,
                  '/login_screen',
                );
              });
            },
          ),
        ],
      );
    },
  );
}
