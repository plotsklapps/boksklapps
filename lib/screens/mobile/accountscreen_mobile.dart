import '../../all_imports.dart';

/// AccountScreenMobile class
class AccountScreenMobile extends ConsumerWidget {
  /// AccountScreenMobile constructor
  const AccountScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? currentEmail = ref.watch(currentUserProvider)?.email;
    final String? currentUserName = ref.watch(currentUserProvider)?.displayName;

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
              currentEmail ?? StringUtils.kNoAccount,
            ),
            subtitle: const Text(
              'Current UserEmail',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () async {
              if (currentEmail != null) {
                await showChangeEmailDialog(context);
              } else {
                await showNoAccountDialog(context);
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
            onTap: () async {
              if (currentEmail != null) {
                await showChangeUserNameDialog(context);
              } else {
                await showNoAccountDialog(context);
              }
            },
          ),
          ListTile(
            title: Text(
              ref.watch(bmiProvider).toString(),
            ),
            subtitle: const Text(
              'Current BMI',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () async {
              if (currentEmail != null) {
                await showChangeAgeHeightWeight(context);
              } else {
                await showNoAccountDialog(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
