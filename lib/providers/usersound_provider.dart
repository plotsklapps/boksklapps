import 'package:boksklapps/all_imports.dart';

// UserSoundStringProvider provides the String which is used in the
// settings_screen to show the user which sound is currently active.
final StateNotifierProvider<UserSoundString, String> userSoundStringProvider =
    StateNotifierProvider<UserSoundString, String>(
        (StateNotifierProviderRef<UserSoundString, String> ref) {
  return UserSoundString();
});

class UserSoundString extends StateNotifier<String> {
  UserSoundString() : super('Elli');

  // Method to set the userSoundStringProvider to the correct String
  // Logic is done in SoundSwitch widget
  Future<void> setUserSoundString(String userSoundString) async {
    state = userSoundString;
  }
}

// UserSoundProvider provides the int which is used in the
// to fetch the correct sound from Firebase Storage
final StateNotifierProvider<UserSoundNotifier, int> userSoundProvider =
    StateNotifierProvider<UserSoundNotifier, int>(
  (StateNotifierProviderRef<UserSoundNotifier, int> ref) {
    return UserSoundNotifier();
  },
);

// UserSoundNotifier class instantiates with default 0, which
// is the int value for the sound 'Ellie'
class UserSoundNotifier extends StateNotifier<int> {
  UserSoundNotifier() : super(0);

  // Method to GET user's preference for sound
  Future<void> getUserSound(WidgetRef ref) async {
    final int userSound = await UserSoundRepository().getUserSound(ref);
    state = userSound;
  }

  // Method to update users preferred sound in Firestore as int
  // when a user is logged in to Firebase, else just change state
  // locally
  Future<void> updateUserSound(
    BuildContext context,
    WidgetRef ref,
    int userSound,
  ) async {
    state = userSound;
    await UserSoundRepository().updateUserSound(
      context,
      ref,
      userSound,
    );
  }
}

class UserSoundRepository {
  // Method to GET users preference for sound. According to
  // the int value, the userSoundProvider and userSoundStringProvider
  // are set to the correct sound and String value via their
  // respective Providers.
  Future<int> getUserSound(
    WidgetRef ref,
  ) async {
    final DocumentSnapshot<Map<String, dynamic>> userSound =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    final int userSoundAsInt = int.parse(
      userSound.data()!['userSound'].toString(),
    );
    return userSoundAsInt;
  }

  // Method to update users preferred sound in Firestore as int
  // and set the userSoundProvider and userSoundStringProvider to the
  // correct sound and String value
  Future<void> updateUserSound(
    BuildContext context,
    WidgetRef ref,
    int newSound,
  ) async {
    // If user is NOT signed in to Firebase only update the
    // userSoundProvider and userSoundStringProvider locally
    Logger().i(
      'Updating user sound locally to $newSound (Sneak Peeker)',
    );
    if (newSound == 0) {
      await ref.read(userSoundStringProvider.notifier).setUserSoundString(
            'Elli',
          );
    } else if (newSound == 1) {
      await ref.read(userSoundStringProvider.notifier).setUserSoundString(
            'Arnold',
          );
    } else {
      await ref.read(userSoundStringProvider.notifier).setUserSoundString(
            'DTMF',
          );
    }
    try {
      // If user IS signed in to Firebase update the themeMode
      // in Firestore database as well
      if (FirebaseAuth.instance.currentUser != null) {
        Logger().i(
          'Updating user newSound to $newSound to Firestore database',
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(<String, int>{'userSound': newSound});
      } else {
        return;
      }
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user userSound: $error');
    }
  }
}
