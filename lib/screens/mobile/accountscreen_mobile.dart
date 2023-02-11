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
              if (currentEmail != null) {
                showChangeEmailDialog(context);
              } else {
                showNoAccountDialog(context);
              }
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
              if (currentEmail != null) {
                showChangeUserNameDialog(context);
              } else {
                showNoAccountDialog(context);
              }
            },
          ),
          ListTile(
            title: Text(
              currentEmail ?? StringUtils.kNoAccount,
            ),
            subtitle: const Text(
              'Current Age / Weight / BMI',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () {
              if (currentEmail != null) {
                showChangeAgeWeightBMI(context);
              } else {
                showNoAccountDialog(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
