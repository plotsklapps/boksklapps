import 'package:boksklapps/all_imports.dart';

final StateNotifierProvider<ThemeModeSwitchNotifier, Set<ThemeModes>>
    themeModeSwitchProvider =
    StateNotifierProvider<ThemeModeSwitchNotifier, Set<ThemeModes>>((_) {
  return ThemeModeSwitchNotifier();
});

class ThemeModeSwitchNotifier extends StateNotifier<Set<ThemeModes>> {
  ThemeModeSwitchNotifier() : super(<ThemeModes>{ThemeModes.light});

  void changeThemeModeValue(ThemeModes value) => state = <ThemeModes>{value};
}

enum ThemeModes { light, system, dark }

class ThemeModeSwitch extends ConsumerStatefulWidget {
  const ThemeModeSwitch({super.key});

  @override
  ConsumerState<ThemeModeSwitch> createState() => ThemeModeSwitchState();
}

class ThemeModeSwitchState extends ConsumerState<ThemeModeSwitch> {
  @override
  Widget build(BuildContext context) {
    final ThemeModes themeModesView = ref.watch(themeModeSwitchProvider).first;
    return SegmentedButton<ThemeModes>(
      segments: const <ButtonSegment<ThemeModes>>[
        ButtonSegment<ThemeModes>(
          value: ThemeModes.light,
          icon: IconUtils.kLightMode,
        ),
        ButtonSegment<ThemeModes>(
          value: ThemeModes.system,
          icon: IconUtils.kSystemMode,
        ),
        ButtonSegment<ThemeModes>(
          value: ThemeModes.dark,
          icon: IconUtils.kDarkMode,
        ),
      ],
      selected: <ThemeModes>{themeModesView},
      onSelectionChanged: (Set<ThemeModes> newSelection) async {
        ref.read(themeModeSwitchProvider.notifier).changeThemeModeValue(
              newSelection.first,
            );
        final ThemeModes themeMode = ref.watch(themeModeSwitchProvider).first;
        if (themeMode == ThemeModes.light) {
          // Set the state of themeModeProvider to Light
          // and set the String of themeModeStringProvider
          await ref.read(userThemeModeNotifier.notifier).updateUserThemeMode(
                context,
                ref,
                0,
              );
          await ref.read(themeModeStringProvider.notifier).setThemeModeString(
                'Light',
              );
        } else if (themeMode == ThemeModes.system) {
          // Set the state of themeModeProvider to System
          // and set the String of themeModeStringProvider
          await ref.read(userThemeModeNotifier.notifier).updateUserThemeMode(
                context,
                ref,
                1,
              );
          await ref.read(themeModeStringProvider.notifier).setThemeModeString(
                'System',
              );
        } else if (themeMode == ThemeModes.dark) {
          // Set the state of themeModeProvider to Dark
          // and set the String of themeModeStringProvider
          await ref.read(userThemeModeNotifier.notifier).updateUserThemeMode(
                context,
                ref,
                2,
              );
          await ref.read(themeModeStringProvider.notifier).setThemeModeString(
                'Dark',
              );
        }
      },
    );
  }
}
