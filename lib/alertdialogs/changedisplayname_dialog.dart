import 'package:boksklapps/all_imports.dart';

/// Shows a dialog to change the displayName to Firebase
/// Method takes context as parameter
Future<void> showChangeUserNameDialog(BuildContext context) async {
  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          /// NameController for username
          final TextEditingController nameCtrl = TextEditingController();

          /// PasswordController
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
                  // Store new displayName to currentUserNameProvider
                  ref.read(currentDisplayNameProvider.notifier).state =
                      nameCtrl.text;
                  // Update display name via Firebase (official way)
                  Logger().i(
                    'Updating Firebase official displayName',
                  );
                  await ref
                      .watch(firebaseProvider)
                      .currentUser
                      ?.updateDisplayName(nameCtrl.text)
                      .then((_) async {
                    // Update the all Firestore database values as well
                    Logger().i(
                      'Updating all Firestore data',
                    );
                    await updateFirestoreData(ref);
                    // Show a snackBar and return to login screen
                    if (context.mounted) {
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
                    }
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
