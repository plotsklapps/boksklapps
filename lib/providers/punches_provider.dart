import 'dart:math';

import 'package:boksklapps/all_imports.dart';

final StateProvider<List<String>> punchListProvider =
    StateProvider<List<String>>(
  (StateProviderRef<List<String>> ref) {
    return <String>[];
  },
);

final StateNotifierProvider<BoxingGloveNotifier, String> boxingGloveProvider =
    StateNotifierProvider<BoxingGloveNotifier, String>(
        (StateNotifierProviderRef<BoxingGloveNotifier, String> ref) {
  return BoxingGloveNotifier();
});

class BoxingGloveNotifier extends StateNotifier<String> {
  BoxingGloveNotifier() : super('assets/punch_jab.png');

  void changeBoxingGlove(WidgetRef ref) {
    final List<String> punchList = ref.watch(punchListProvider);
    final int randomIndex = Random().nextInt(punchList.length);
    String newGloveImage;
    switch (punchList[randomIndex]) {
      case '1':
        newGloveImage = 'assets/punch_jab.png';
        break;
      case '2':
        newGloveImage = 'assets/punch_cross.png';
        break;
      case '3':
        newGloveImage = 'assets/punch_leadhook.png';
        break;
      case '4':
        newGloveImage = 'assets/punch_rearhook.png';
        break;
      default:
        newGloveImage = 'assets/punch_jab.png';
        break;
    }

    // Change the state of the provider with a delay
    Future<void>.delayed(const Duration(milliseconds: 100), () {
      state = newGloveImage;
    });
  }
}

final StateProvider<String> boxingNumberProvider =
    StateProvider<String>((StateProviderRef<String> ref) {
  final List<String> punchList = ref.watch(punchListProvider);
  final String boxingGloveImage = ref.watch(boxingGloveProvider);
  final int punchIndex = <String>[
    'assets/punch_jab.png',
    'assets/punch_cross.png',
    'assets/punch_leadhook.png',
    'assets/punch_rearhook.png',
  ].indexOf(boxingGloveImage);
  return punchList[punchIndex];
});

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
    // ThemeMode.light + FlexScheme.outerSpace
    if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      return isOn ? FlexColor.outerSpaceLightPrimaryContainer : Colors.grey;
    }
    // ThemeMode.system + FlexScheme.outerSpace
    else if (ref.watch(themeModeProvider) == ThemeMode.system &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      return isOn ? FlexColor.outerSpaceDarkPrimaryContainer : Colors.grey;
    }
    // ThemeMode.dark + FlexScheme.outerSpace
    else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      return isOn ? FlexColor.outerSpaceDarkPrimaryContainer : Colors.grey;
    }
    // ThemeMode.light + FlexScheme.money
    else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      return isOn ? FlexColor.moneyLightPrimaryContainer : Colors.grey;
    }
    // ThemeMode.system + FlexScheme.money
    else if (ref.watch(themeModeProvider) == ThemeMode.system &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      return isOn ? FlexColor.moneyDarkPrimaryContainer : Colors.grey;
    }
    // ThemeMode.dark + FlexScheme.money
    else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      return isOn ? FlexColor.moneyDarkPrimaryContainer : Colors.grey;
    }
    // ThemeMode.light + FlexScheme.redWine
    else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      return isOn ? FlexColor.redWineLightPrimaryContainer : Colors.grey;
    }
    // ThemeMode.system + FlexScheme.redWine
    else if (ref.watch(themeModeProvider) == ThemeMode.system &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      return isOn ? FlexColor.redWineDarkPrimaryContainer : Colors.grey;
    }
    // ThemeMode.dark + FlexScheme.redWine
    else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      return isOn ? FlexColor.redWineDarkPrimaryContainer : Colors.grey;
    }
    return Colors.grey;
  }
}

class ButtonState {
  final bool isOn;
  final Color color;

  ButtonState(this.isOn, this.color);
}
