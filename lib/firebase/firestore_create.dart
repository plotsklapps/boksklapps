import 'package:boksklapps/all_imports.dart';

// Future method that returns void, but handles updating
// ALL values to Firestore and sets currentUser.displayName
// and currentUser.email to FirebaseAuth to make sure they
// are the same.

Future<void> createFirestoreData(
  BuildContext context,
  WidgetRef ref,
  String userEmail,
  String displayName,
) async {
  Logger().i(
    'Creating new database...',
  );
  // Update ALL data within the database with corresponding
  // data from the providers. Providers cannot be null,
  // they have a default value, which user can change later.
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set(<String, dynamic>{
    'userEmail': ref.watch(userEmailProvider),
    'userName': ref.watch(userDisplayNameProvider),
    'userAge': ref.watch(userAgeProvider),
    'userHeight': ref.watch(userHeightProvider),
    'userWeight': ref.watch(userWeightProvider),
    'userBMI': ref.watch(userBMIProvider),
    'themeColor': ref.watch(userThemeColorNotifier),
    'themeMode': ref.watch(userThemeModeNotifier),
    'totalTimer': ref.watch(totalTimerProvider),
    'setTimer': ref.watch(setTimerProvider),
    'restTimer': ref.watch(restTimerProvider),
  });
}
