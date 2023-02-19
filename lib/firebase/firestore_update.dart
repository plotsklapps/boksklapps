import 'package:boksklapps/all_imports.dart';

// This method should be called every time a user changes any of the
// Firestore Data, so that the all data is updated in the Firestore.
Future<void> updateFirestoreData(
  BuildContext context,
  WidgetRef ref,
) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set(<String, dynamic>{
    'userName': ref.watch(userDisplayNameProvider),
    'userEmail': ref.watch(userThemeModeNotifier),
    'userAge': ref.watch(userAgeProvider),
    'userHeight': ref.watch(userHeightProvider),
    'userWeight': ref.watch(userWeightProvider),
    'userBMI': ref.watch(userBMIProvider),
    'themeColor': ref.watch(userThemeColorNotifier),
    'themeMode': ref.watch(userThemeModeNotifier),
  });
}
