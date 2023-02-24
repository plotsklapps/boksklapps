import 'package:boksklapps/all_imports.dart';

final StateProvider<List<String>> punchListProvider =
    StateProvider<List<String>>(
  (StateProviderRef<List<String>> ref) {
    return <String>[];
  },
);

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch1Provider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch2Provider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch3Provider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch4Provider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch5Provider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch6Provider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch1BProvider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch2BProvider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch3BProvider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

final StateNotifierProvider<ButtonStateNotifier, ButtonState> punch4BProvider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
        (StateNotifierProviderRef<ButtonStateNotifier, ButtonState> ref) {
  return ButtonStateNotifier();
});

class ButtonStateNotifier extends StateNotifier<ButtonState> {
  ButtonStateNotifier() : super(ButtonState(false, Colors.grey));

  void toggle(WidgetRef ref) {
    state = ButtonState(!state.isOn, _getButtonColor(!state.isOn, ref));
  }

  Color _getButtonColor(
    bool isOn,
    WidgetRef ref,
  ) {
    if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      return isOn ? FlexColor.outerSpaceLightPrimaryContainer : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      return isOn ? FlexColor.outerSpaceDarkPrimary : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      return isOn ? FlexColor.moneyLightPrimaryContainer : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      return isOn ? FlexColor.moneyDarkPrimary : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      return isOn ? FlexColor.redWineLightPrimaryContainer : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      return isOn ? FlexColor.redWineDarkPrimary : Colors.grey;
    }
    return Colors.grey;
  }
}

class ButtonState {
  final bool isOn;
  final Color color;

  ButtonState(this.isOn, this.color);
}
