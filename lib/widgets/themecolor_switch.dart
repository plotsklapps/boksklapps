import 'package:boksklapps/all_imports.dart';

final StateNotifierProvider<ThemeColorSwitchNotifier, Set<ThemeColors>>
    themeColorSwitchProvider =
    StateNotifierProvider<ThemeColorSwitchNotifier, Set<ThemeColors>>((_) {
  return ThemeColorSwitchNotifier();
});

class ThemeColorSwitchNotifier extends StateNotifier<Set<ThemeColors>> {
  ThemeColorSwitchNotifier() : super(<ThemeColors>{ThemeColors.outerspace});

  void changeThemeColorValue(ThemeColors value) => state = <ThemeColors>{value};
}

enum ThemeColors { outerspace, greenmoney, redredwine }

class ThemeColorSwitch extends ConsumerStatefulWidget {
  const ThemeColorSwitch({super.key});

  @override
  ConsumerState<ThemeColorSwitch> createState() => ThemeColorSwitchState();
}

class ThemeColorSwitchState extends ConsumerState<ThemeColorSwitch> {
  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColorsView =
        ref.watch(themeColorSwitchProvider).first;
    return SegmentedButton<ThemeColors>(
      segments: const <ButtonSegment<ThemeColors>>[
        ButtonSegment<ThemeColors>(
          value: ThemeColors.outerspace,
          icon: IconUtils.kOuterSpace,
        ),
        ButtonSegment<ThemeColors>(
          value: ThemeColors.greenmoney,
          icon: IconUtils.kGreenMoney,
        ),
        ButtonSegment<ThemeColors>(
          value: ThemeColors.redredwine,
          icon: IconUtils.kRedWine,
        ),
      ],
      selected: <ThemeColors>{themeColorsView},
      onSelectionChanged: (Set<ThemeColors> newSelection) async {
        ref.read(themeColorSwitchProvider.notifier).changeThemeColorValue(
              newSelection.first,
            );
        final ThemeColors themeColor =
            ref.watch(themeColorSwitchProvider).first;
        if (themeColor == ThemeColors.outerspace) {
          // Set the state of themeColorProvider to Outer Space
          // and set the String of themeColorProvider
          await ref.read(userThemeColorNotifier.notifier).updateUserThemeColor(
                context,
                ref,
                0,
              );
          await ref.read(themeColorStringProvider.notifier).setThemeColorString(
                'Outer Space',
              );
        } else if (themeColor == ThemeColors.greenmoney) {
          // Set the state of themeColorProvider to Green Money
          // and set the String of themeColorProvider
          await ref.read(userThemeColorNotifier.notifier).updateUserThemeColor(
                context,
                ref,
                1,
              );
          await ref.read(themeColorStringProvider.notifier).setThemeColorString(
                'Green Money',
              );
        } else if (themeColor == ThemeColors.redredwine) {
          // Set the state of themeColorProvider to Red Red Wine
          // and set the String of themeColorProvider
          await ref.read(userThemeColorNotifier.notifier).updateUserThemeColor(
                context,
                ref,
                2,
              );
          await ref.read(themeColorStringProvider.notifier).setThemeColorString(
                'Red Red Wine',
              );
        }
      },
    );
  }
}
