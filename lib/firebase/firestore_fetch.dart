import 'package:boksklapps/all_imports.dart';

/// This method should be called every time a screen is opened that needs
/// to fetch data from Firestore
Future<void> fetchFirestoreData(
  BuildContext context,
  WidgetRef ref,
) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> userData = await ref
        .watch(firestoreProvider)
        .collection('users')
        .doc(ref.watch(firebaseProvider).currentUser?.uid)
        .get();
    ref.read(currentDisplayNameProvider.notifier).state =
        userData.data()?['userName'].toString();
    ref.read(currentEmailProvider.notifier).state =
        userData.data()?['userEmail'].toString();
    ref.read(ageProvider.notifier).state = UserAgeRepository().getUserAge();
    ref.read(heightProvider.notifier).state =
        int.parse(userData.data()!['userHeight'].toString());
    ref.read(weightProvider.notifier).state =
        int.parse(userData.data()!['userWeight'].toString());
    ref.read(bmiProvider.notifier).state =
        double.parse(userData.data()!['userBMI'].toString());
  } catch (error) {
    Logger().i(
      'Something went wrong... $error',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Something went wrong... $error',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}
