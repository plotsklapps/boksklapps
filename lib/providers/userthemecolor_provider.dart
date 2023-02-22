import 'package:boksklapps/all_imports.dart';

// ThemeColor setting is done in the settings_screen.dart. User
// can choose between 3 different colors. All ThemeColor providers
// are set to FlexScheme.outerSpace (int == 0) by default.
// Firestore only accepts Strings and int as values, so the
// userThemeColorNotifier sets and returns the int value of the
// themeColor field in the user document in Firestore database.
// With getUserThemeColor() method, the int value is translated
// a FlexScheme and String value and put in the themeColorProvider
// and themeModeStringProvider.

// themeColorProvider returns a FlexScheme.'something' to be used in the
// Light and Dark Theme Providers
final StateNotifierProvider<ThemeColorState, FlexScheme> themeColorProvider =
    StateNotifierProvider<ThemeColorState, FlexScheme>(
        (StateNotifierProviderRef<ThemeColorState, FlexScheme> ref) {
  return ThemeColorState();
});

// ThemeColorState class
class ThemeColorState extends StateNotifier<FlexScheme> {
  ThemeColorState() : super(FlexScheme.outerSpace);

  Future<void> setThemeColor(FlexScheme flexScheme) async {
    state = flexScheme;
  }
}

final StateNotifierProvider<UserThemeColorNotifier, int>
    userThemeColorNotifier = StateNotifierProvider<UserThemeColorNotifier, int>(
        (StateNotifierProviderRef<UserThemeColorNotifier, int> ref) {
  // Returns instance of type int (default: 0)
  return UserThemeColorNotifier();
});

class UserThemeColorNotifier extends StateNotifier<int> {
  UserThemeColorNotifier() : super(0);

  // Method to GET user's preference for theme mode. According to
  // the int value, the themeModeProvider and themeModeStringProvider
  // are set to the correct ThemeMode and String value via their
  // respective Providers.
  Future<void> getUserThemeColor(
    WidgetRef ref,
  ) async {
    final int themeColorInt =
        await UserThemeColorRepository().getUserThemeColor(ref);
    if (themeColorInt == 0) {
      await ref
          .read(themeColorProvider.notifier)
          .setThemeColor(FlexScheme.outerSpace);
      await ref.read(themeModeStringProvider.notifier).setThemeModeString(
            'Outer Space',
          );
    } else if (themeColorInt == 1) {
      await ref
          .read(themeColorProvider.notifier)
          .setThemeColor(FlexScheme.money);
      await ref.read(themeModeStringProvider.notifier).setThemeModeString(
            'Green Money',
          );
    } else {
      await ref
          .read(themeColorProvider.notifier)
          .setThemeColor(FlexScheme.redWine);
      await ref.read(themeModeStringProvider.notifier).setThemeModeString(
            'Red Red Wine',
          );
    }
  }

  // Method to UPDATE user's preference for theme mode. It reads the
  // int from newThemeMode sets the themeMode and themeModeString
  // accordingly.
  Future<void> updateUserThemeColor(
    BuildContext context,
    WidgetRef ref,
    int newThemeColor,
  ) async {
    await UserThemeColorRepository().updateUserThemeColor(
      context,
      ref,
      newThemeColor,
    );
    state = newThemeColor;
  }
}

// Repository class for UserThemeColorNotifier to use to fetch and set
// user's preferred ThemeColor from and to Firestore database
class UserThemeColorRepository {
  // Method to get user's preferred ThemeColor from Firestore as int
  Future<int> getUserThemeColor(
    WidgetRef ref,
  ) async {
    final DocumentSnapshot<Map<String, dynamic>> userThemeColorDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return int.parse(
      userThemeColorDoc.data()!['themeColor'].toString(),
    );
  }

  // Method to update user's preferred themeColor in Firestore as int
  // and set the themeColorProvider and themeColorStringProvider to the
  // correct ThemeColor and String value
  Future<void> updateUserThemeColor(
    BuildContext context,
    WidgetRef ref,
    int newThemeColor,
  ) async {
    // If user is NOT signed in to Firebase only update the
    // themeModeProvider and themeModeStringProvider locally
    Logger().i(
      'Updating user themeMode locally to $newThemeColor (Sneak Peeker)',
    );
    if (newThemeColor == 0) {
      await ref.read(themeColorProvider.notifier).setThemeColor(
            FlexScheme.outerSpace,
          );
      await ref.read(themeColorStringProvider.notifier).setThemeColorString(
            'Outer Space',
          );
    } else if (newThemeColor == 1) {
      await ref.read(themeColorProvider.notifier).setThemeColor(
            FlexScheme.money,
          );
      await ref.read(themeColorStringProvider.notifier).setThemeColorString(
            'Green Money',
          );
    } else {
      await ref.read(themeColorProvider.notifier).setThemeColor(
            FlexScheme.redWine,
          );
      await ref.read(themeColorStringProvider.notifier).setThemeColorString(
            'Red Red Wine',
          );
    }
    try {
      // If user IS signed in to Firebase update the themeMode
      // in Firestore database as well
      if (FirebaseAuth.instance.currentUser != null) {
        Logger().i(
          'Updating user themeColor to $newThemeColor to Firestore database',
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(<String, int>{'themeColor': newThemeColor});
      } else {
        return;
      }
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user themeColor: $error');
    }
  }
}

// ThemeColorString Provider provides the String which is used in the
// settings_screen to show the user which color is currently active.
final StateNotifierProvider<ThemeColorString, String> themeColorStringProvider =
    StateNotifierProvider<ThemeColorString, String>(
        (StateNotifierProviderRef<ThemeColorString, String> ref) {
  return ThemeColorString();
});

// ThemeColorString class
class ThemeColorString extends StateNotifier<String> {
  ThemeColorString() : super('Outer Space');

  Future<void> setThemeColorString(String themeColorString) async {
    state = themeColorString;
  }
}
