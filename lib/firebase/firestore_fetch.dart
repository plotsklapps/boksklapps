import 'package:boksklapps/all_imports.dart';

/// This method should be called every time a screen is opened that needs
/// to fetch data from Firestore
Future<void> fetchFirestoreData(
  BuildContext context,
  WidgetRef ref,
) async {
  try {
    await ref.read(userEmailProvider.notifier).getUserEmail();
    await ref.read(userDisplayNameProvider.notifier).getUserDisplayName();
    await ref.read(userAgeProvider.notifier).getUserAge();
    await ref.read(userHeightProvider.notifier).getUserHeight();
    await ref.read(userWeightProvider.notifier).getUserWeight();
    await ref.read(userBMIProvider.notifier).getUserBMI();
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
