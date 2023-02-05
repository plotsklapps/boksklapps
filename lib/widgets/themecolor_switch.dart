import 'package:boksklapps/all_imports.dart';

/// ThemeColorSwitch class
class ThemeColorSwitch extends ConsumerWidget {
  /// ThemeColorSwitch constructor
  const ThemeColorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = <bool>[
      ref.watch(themeColorProvider) == FlexScheme.outerSpace,
      ref.watch(themeColorProvider) == FlexScheme.money,
      ref.watch(themeColorProvider) == FlexScheme.redWine,
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
          //Set the state of themeColorProvider to Outer Space
          //and set the String of themeColorProvider
          ref.read(themeColorProvider.notifier).setThemeOuterSpace();
          ref
              .read(themeColorStringProvider.notifier)
              .setThemeColorStringOuterSpace();
        } else if (newIndex == 1) {
          //Set the state of themeColorProvider to Green Money
          //and set the String of themeColorProvider
          ref.read(themeColorProvider.notifier).setThemeGreenMoney();
          ref
              .read(themeColorStringProvider.notifier)
              .setThemeColorStringGreenMoney();
        } else {
          //Set the state of themeColorProvider to Red Red Wine
          //and set the String of themeColorProvider
          ref.read(themeColorProvider.notifier).setThemeRedWine();
          ref
              .read(themeColorStringProvider.notifier)
              .setThemeColorStringRedWine();
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
