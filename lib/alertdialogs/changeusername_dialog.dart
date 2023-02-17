import 'package:boksklapps/all_imports.dart';

/// Shows a dialog to change the username
/// Method takes context as parameter
Future<void> showChangeUserNameDialog(
  BuildContext context,
  WidgetRef ref,
) async {
  /// NameController for username
  final TextEditingController nameCtrl = TextEditingController();

  /// PasswordController
  final TextEditingController passwordCtrl = TextEditingController();

  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
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
                labelText: StringUtils.kUserName,
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
              'OK',
            ),
            onPressed: () async {
              // Update display name via Firebase (official way)
              await ref
                  .watch(currentUserProvider)
                  ?.updateDisplayName(nameCtrl.text)
                  .then((_) async {
                // Update the all Firestore database values as well
                await ref
                    .watch(firestoreProvider)
                    .collection('users')
                    .doc(ref.watch(currentUserProvider)!.uid)
                    .set(<String, dynamic>{
                  'userName': ref.watch(currentUserNameProvider),
                  'userEmail': ref.watch(currentEmailProvider),
                  'userAge': ref.watch(ageProvider),
                  'userHeight': ref.watch(heightProvider),
                  'userWeight': ref.watch(weightProvider),
                  'userBMI': ref.watch(bmiProvider),
                  'themeColor': 0,
                  'themeMode': 0,
                }).then((_) {
                  // Show a SnackBar and return to login screen
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
                });
                if (context.mounted) {
                  await Navigator.pushReplacementNamed(
                    context,
                    '/login_screen',
                  );
                }
              });
            },
          ),
        ],
      );
    },
  );
}
