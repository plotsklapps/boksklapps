import 'package:boksklapps/all_imports.dart';

/// This method should be called every time a user changes any of the
/// Firestore Data, so that the all data is updated in the Firestore.
Future<void> updateFirestoreData(
  BuildContext context,
  WidgetRef ref,
) async {
  await ref
      .watch(firestoreProvider)
      .collection('users')
      .doc(ref.watch(firebaseProvider).currentUser!.uid)
      .set(<String, dynamic>{
    'userName': ref.watch(currentDisplayNameProvider),
    'userEmail': ref.watch(currentEmailProvider),
    'userAge': ref.watch(ageProvider),
    'userHeight': ref.watch(heightProvider),
    'userWeight': ref.watch(weightProvider),
    'userBMI': ref.watch(bmiProvider),
    'themeColor': 0,
    'themeMode': 0,
  });
}
