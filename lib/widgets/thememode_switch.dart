import 'package:boksklapps/all_imports.dart';

/// ThemeModeSwitch class
class ThemeModeSwitch extends ConsumerWidget {
  /// ThemeModeSwitch constructor
  const ThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = <bool>[
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
      onPressed: (int newIndex) {
        if (newIndex == 0) {
          //Set the state of themeModeProvider to ThemeMode.light
          //and set the String of themeModeStringProvider
          ref.read(themeModeProvider.notifier).state = ThemeMode.light;
          ref.read(themeModeStringProvider.notifier).setThemeModeStringLight();
        } else if (newIndex == 1) {
          //Set the state of themeModeProvider to ThemeMode.system
          //and set the String of themeModeStringProvider
          ref.read(themeModeProvider.notifier).state = ThemeMode.system;
          ref.read(themeModeStringProvider.notifier).setThemeModeStringSystem();
        } else {
          //Set the state of themeModeProvider to ThemeMode.dark
          //and set the String of themeModeStringProvider
          ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
          ref.read(themeModeStringProvider.notifier).setThemeModeStringDark();
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
