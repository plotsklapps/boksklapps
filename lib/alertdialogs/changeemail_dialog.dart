import 'package:boksklapps/all_imports.dart';

/// Shows a dialog to change the email address to Firebase
/// Method takes context as parameter
Future<void> showChangeEmailDialog(BuildContext context) async {
  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          /// EmailController for old email
          final TextEditingController email1Ctrl = TextEditingController();

          /// EmailController for new email
          final TextEditingController email2Ctrl = TextEditingController();

          /// PasswordController
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
                  'OK',
                ),
                onPressed: () async {
                  // Store new email value to currentEmailProvider
                  ref.read(currentEmailProvider.notifier).state =
                      email2Ctrl.text;

                  await ref
                      .watch(currentUserProvider)!
                      .reauthenticateWithCredential(
                        EmailAuthProvider.credential(
                          email: email1Ctrl.text,
                          password: passwordCtrl.text,
                        ),
                      )
                      .then((_) {
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
                  });
                  await ref
                      .watch(currentUserProvider)!
                      .updateEmail(email2Ctrl.text)
                      .then((_) {
                    updateFirestoreData(ref).then(
                      (_) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/login_screen',
                        );
                      },
                    );
                  });
                },
              ),
            ],
          );
        },
      );
    },
  );
}
