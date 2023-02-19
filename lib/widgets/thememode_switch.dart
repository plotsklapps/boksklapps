import 'package:boksklapps/all_imports.dart';

/// ThemeModeSwitch class
class ThemeModeSwitch extends ConsumerWidget {
  /// ThemeModeSwitch constructor
  const ThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<bool> isSelected = <bool>[
      ref.watch(themeModeProvider) == ThemeMode.light,
      ref.watch(themeModeProvider) == ThemeMode.system,
      ref.watch(themeModeProvider) == ThemeMode.dark,
    ];

    return ToggleButtons(
      //The state of each button is controlled by isSelected,
      //which is a list of bools that determine if a button
      //is in an active, disabled, or selected state.
      //They are both correlated by their index in the list.
      //The length of isSelected has to match
      //the length of the children list.
      isSelected: isSelected,
      onPressed: (int newIndex) async {
        // Set the state of themeModeProvider to state of int and
        // set the String of themeModeStringProvider state of int
        // as well and update the user's preference for theme mode
        // in Firestore database
        if (newIndex == 0) {
          await ref.read(userThemeModeNotifier.notifier).updateUserThemeMode(
                context,
                ref,
                0,
              );
        } else if (newIndex == 1) {
          await ref.read(userThemeModeNotifier.notifier).updateUserThemeMode(
                context,
                ref,
                1,
              );
        } else {
          await ref.read(userThemeModeNotifier.notifier).updateUserThemeMode(
                context,
                ref,
                2,
              );
        }
      },
      children: const <Icon>[
        IconUtils.kLightMode,
        IconUtils.kSystemMode,
        IconUtils.kDarkMode,
      ],
    );
  }
}
