import 'package:boksklapps/alertdialogs/changebmi_dialog.dart';
import 'package:boksklapps/all_imports.dart';

/// AccountScreenMobile class
class AccountScreenMobile extends ConsumerWidget {
  /// AccountScreenMobile constructor
  const AccountScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringUtils.kAccount,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <ListTile>[
          ListTile(
            title: Text(
              ref.watch(userEmailProvider) ?? StringUtils.kNoAccount,
            ),
            subtitle: const Text(
              'Current UserEmail',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () async {
              // If the user is logged in, show the dialog to change
              // the email address
              if (ref.watch(userEmailProvider) == 'Sneak Peeker') {
                await showNoAccountDialog(context);
              } else {
                await showChangeEmailDialog(context);
              }
            },
          ),
          ListTile(
            title: Text(
              ref.watch(userDisplayNameProvider) ?? StringUtils.kNoAccount,
            ),
            subtitle: const Text(
              'Current UserName',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () async {
              // If the user is logged in, show the dialog to change
              // the username
              if (ref.watch(userEmailProvider) == 'Sneak Peeker') {
                await showNoAccountDialog(context);
              } else {
                await showChangeUserDisplayNameDialog(context);
              }
            },
          ),
          ListTile(
            title: Text(
              ref.watch(userBMIProvider),
            ),
            subtitle: const Text(
              'Current BMI',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () async {
              // If the user is logged in, show the dialog to change
              // the age, height, weight and calculate BMI
              if (ref.watch(userEmailProvider) == 'Sneak Peeker') {
                await showNoAccountDialog(context);
              } else {
                await showChangeUserBMIDialog(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
