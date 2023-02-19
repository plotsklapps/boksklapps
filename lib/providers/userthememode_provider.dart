import 'package:boksklapps/all_imports.dart';

// ThemeMode setting is done in the settings_screen.dart. User
// can choose between Light(0), System(1) and Dark(2) theme. All
// ThemeMode providers are set to 0 by default.
// Firestore only accepts Strings and int as values, so the
// userThemeModeNotifier sets and returns the int value of the
// themeMode field in the user document in Firestore database.
// With getUserThemeMode() method, the int value is translated
// a ThemeMode and String value and put in the themeModeProvider
// and themeModeStringProvider.

// Provider that returns instance of type ThemeMode
// (default: ThemeMode.light)
final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((StateProviderRef<ThemeMode> ref) {
  return ThemeMode.light;
});

final StateNotifierProvider<UserThemeModeNotifier, int> userThemeModeNotifier =
    StateNotifierProvider<UserThemeModeNotifier, int>(
        (StateNotifierProviderRef<UserThemeModeNotifier, int> ref) {
  // Returns instance of type int (default: 0)
  return UserThemeModeNotifier();
});

class UserThemeModeNotifier extends StateNotifier<int> {
  UserThemeModeNotifier() : super(0);

  // Method to GET user's preference for theme mode. According to
  // the int value, the themeModeProvider and themeModeStringProvider
  // are set to the correct ThemeMode and String value via their
  // respective Providers.
  Future<void> getUserThemeMode(
    WidgetRef ref,
  ) async {
    final int themeModeInt =
        await UserThemeModeRepository().getUserThemeMode(ref);
    if (themeModeInt == 0) {
      ref.read(themeModeProvider.notifier).state = ThemeMode.light;
      await ref.read(themeModeStringProvider.notifier).setThemeModeString(
            'Light',
          );
    } else if (themeModeInt == 1) {
      ref.read(themeModeProvider.notifier).state = ThemeMode.system;
      await ref.read(themeModeStringProvider.notifier).setThemeModeString(
            'System',
          );
    } else {
      ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
      await ref.read(themeModeStringProvider.notifier).setThemeModeString(
            'Dark',
          );
    }
  }

  // Method to UPDATE user's preference for theme mode. It reads the
  // int from newThemeMode sets the themeMode and themeModeString
  // accordingly.
  Future<void> updateUserThemeMode(
    BuildContext context,
    WidgetRef ref,
    int newThemeMode,
  ) async {
    await UserThemeModeRepository().updateUserThemeMode(
      ref,
      newThemeMode,
    );
    state = newThemeMode;
  }
}

// Repository class for UserThemeModeNotifier to use to fetch and set
// user's preferred ThemeMode from and to Firestore database
class UserThemeModeRepository {
  // Method to get user's preferred ThemeMode from Firestore as int
  Future<int> getUserThemeMode(
    WidgetRef ref,
  ) async {
    final DocumentSnapshot<Map<String, dynamic>> userThemeModeDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();
    return int.parse(
      userThemeModeDoc.data()!['themeMode'].toString(),
    );
  }

  // Method to update user's preferred ThemeMode in Firestore as int
  // and set the themeModeProvider and themeModeStringProvider to the
  // correct ThemeMode and String value
  Future<void> updateUserThemeMode(
    WidgetRef ref,
    int newThemeMode,
  ) async {
    if (newThemeMode == 0) {
      ref.read(themeModeProvider.notifier).state = ThemeMode.light;
      await ref.read(themeModeStringProvider.notifier).setThemeModeString(
            'Light',
          );
    } else if (newThemeMode == 1) {
      ref.read(themeModeProvider.notifier).state = ThemeMode.system;
      await ref.read(themeModeStringProvider.notifier).setThemeModeString(
            'System',
          );
    } else {
      ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
      await ref.read(themeModeStringProvider.notifier).setThemeModeString(
            'Dark',
          );
    }
    try {
      Logger().i(
        'Updating user themeMode to $newThemeMode to Firestore database',
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(<String, int>{'themeMode': newThemeMode});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user themeMode: $error');
    }
  }
}

// Provider that returns instance of type String
// (default: 'Light')
final StateNotifierProvider<ThemeModeString, String> themeModeStringProvider =
    StateNotifierProvider<ThemeModeString, String>(
        (StateNotifierProviderRef<ThemeModeString, String> ref) {
  return ThemeModeString();
});

// Class that gives access to a method that sets the state of the
// themeModeStringProvider
class ThemeModeString extends StateNotifier<String> {
  ThemeModeString() : super('Light');

  Future<void> setThemeModeString(String themeModeString) async {
    state = themeModeString;
  }
}
