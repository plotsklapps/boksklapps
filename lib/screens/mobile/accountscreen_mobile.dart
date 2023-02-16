import '../../all_imports.dart';

/// AccountScreenMobile class
class AccountScreenMobile extends ConsumerWidget {
  /// AccountScreenMobile constructor
  const AccountScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? currentEmail = FirebaseAuth.instance.currentUser?.email;
    final String? currentUserName =
        FirebaseAuth.instance.currentUser?.displayName;

    /// Return double 'userBMI' from Firestore
    Future<double> getUserBMI() async {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final User? user = FirebaseAuth.instance.currentUser;
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestore.collection('users').doc(user?.uid).get();
      final double userBMI = documentSnapshot.get('userBMI') as double;
      return userBMI;
    }

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
              getUserBMI().toString(),
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
