import 'package:boksklapps/all_imports.dart';

// Future method that returns void, but handles fetching
// ALL values from Firestore and sets currentUser.displayName
// and currentUser.email from FirebaseAuth to make sure they
// are the same.

Future<void> getFirestoreData(
  BuildContext context,
  WidgetRef ref,
) async {
  final String? displayName = FirebaseAuth.instance.currentUser!.displayName;
  final String? userEmail = FirebaseAuth.instance.currentUser!.email;
  try {
    if (context.mounted) {
      Logger().i('');
      // Set the displayName to the one known from Firebase
      await ref
          .read(userDisplayNameProvider.notifier)
          .updateUserDisplayName(
            context,
            displayName!,
          )
          .then((_) async {
        // Set the userEmail to the one known from Firebase
        await ref.read(userEmailProvider.notifier).updateUserEmail(
              context,
              userEmail!,
            );
      }).then((_) async {
        // Get the rest via their respective Providers and notifiers
        await ref.read(userThemeModeNotifier.notifier).getUserThemeMode(ref);
        await ref.read(userThemeColorNotifier.notifier).getUserThemeColor(ref);
        await ref.read(userAgeProvider.notifier).getUserAge();
        await ref.read(userHeightProvider.notifier).getUserHeight();
        await ref.read(userWeightProvider.notifier).getUserWeight();
        await ref.read(userBMIProvider.notifier).getUserBMI();
      });
    }
  } catch (error) {
    Logger().i(
      'Something went wrong... $error',
    );
  }
}
