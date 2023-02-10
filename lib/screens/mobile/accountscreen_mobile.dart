import 'package:boksklapps/all_imports.dart';

/// AccountScreenMobile class
class AccountScreenMobile extends ConsumerWidget {
  /// AccountScreenMobile constructor
  const AccountScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentEmail = FirebaseAuth.instance.currentUser?.email;
    final currentUserName = FirebaseAuth.instance.currentUser?.displayName;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringUtils.kAccount,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text(
              currentEmail ?? StringUtils.kNoAccount,
            ),
            subtitle: const Text(
              'Current UserEmail',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () {
              showChangeEmailDialog(context);
            },
          ),
          ListTile(
            title: Text(
              currentUserName ?? StringUtils.kNoAccount,
            ),
            subtitle: const Text(
              'Current UserName',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () {
              showChangeUserNameDialog(context);
            },
          ),
          ListTile(
            title: Text(
              currentEmail ?? StringUtils.kNoAccount,
            ),
            subtitle: const Text(
              'Current User',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () {
              showChangeEmailDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
