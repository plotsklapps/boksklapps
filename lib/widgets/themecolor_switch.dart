import 'package:boksklapps/all_imports.dart';

// ThemeColorSwitch class
class ThemeColorSwitch extends ConsumerWidget {
  // ThemeColorSwitch constructor
  const ThemeColorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<bool> isSelected = <bool>[
      ref.watch(themeColorProvider) == FlexScheme.outerSpace,
      ref.watch(themeColorProvider) == FlexScheme.money,
      ref.watch(themeColorProvider) == FlexScheme.redWine,
    ];

    return ToggleButtons(
      // The state of each button is controlled by isSelected,
      // which is a list of bools that determine if a button
      // is in an active, disabled, or selected state.
      // They are both correlated by their index in the list.
      // The length of isSelected has to match
      // the length of the children list.
      isSelected: isSelected,
      onPressed: (int newIndex) async {
        if (newIndex == 0) {
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
        } else if (newIndex == 1) {
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
        } else {
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
      children: const <Icon>[
        IconUtils.kOuterSpace,
        IconUtils.kGreenMoney,
        IconUtils.kRedWine,
      ],
    );
  }
}
