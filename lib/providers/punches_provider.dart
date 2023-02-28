import 'dart:math';

import 'package:boksklapps/all_imports.dart';

// StateProvider that returns a List of Strings with the punches
// that the user has selected in the PunchesScreen()
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
    // Picks a random index from the punchList which is provided by
    // the randomIntProvider
    final int randomIndex =
        Random().nextInt(ref.watch(punchListProvider).length);
    debugPrint('randomIndex: $randomIndex');
    String newGloveImage;
    // Set what image to use based on the randomIndex
    if (randomIndex == 0) {
      newGloveImage = 'assets/punch_jab.png';
    } else if (randomIndex == 1) {
      newGloveImage = 'assets/punch_cross.png';
    } else if (randomIndex == 2) {
      newGloveImage = 'assets/punch_leadhook.png';
    } else if (randomIndex == 3) {
      newGloveImage = 'assets/punch_rearhook.png';
    } else if (randomIndex == 4) {
      newGloveImage = 'assets/punch_leaduppercut.png';
    } else if (randomIndex == 5) {
      newGloveImage = 'assets/punch_rearuppercut.png';
    } else if (randomIndex == 6) {
      newGloveImage = 'assets/punch_bodyjab.png';
    } else if (randomIndex == 7) {
      newGloveImage = 'assets/punch_bodycross.png';
    } else if (randomIndex == 8) {
      newGloveImage = 'assets/punch_leadbodyhook.png';
    } else if (randomIndex == 9) {
      newGloveImage = 'assets/punch_rearbodyhook.png';
    } else {
      Logger().i(
        'Something went wrong in changeBoxingGlove...',
      );
      newGloveImage = 'assets/punch_jab.png';
    }
    // Change the state of the provider
    state = newGloveImage;
  }
}

final StateNotifierProvider<BoxingNumberNotifier, String> boxingNumberProvider =
    StateNotifierProvider<BoxingNumberNotifier, String>(
        (StateNotifierProviderRef<BoxingNumberNotifier, String> ref) {
  return BoxingNumberNotifier();
});

class BoxingNumberNotifier extends StateNotifier<String> {
  BoxingNumberNotifier() : super('1');

  void changeBoxingNumber(WidgetRef ref) {
    // Watch the boxingGloveProvider and get the current state
    // as a String
    final String boxingGloveImage = ref.watch(boxingGloveProvider);
    String newGloveNumber;
    if (boxingGloveImage == 'assets/punch_jab.png') {
      newGloveNumber = '1';
    } else if (boxingGloveImage == 'assets/punch_cross.png') {
      newGloveNumber = '2';
    } else if (boxingGloveImage == 'assets/punch_leadhook.png') {
      newGloveNumber = '3';
    } else if (boxingGloveImage == 'assets/punch_rearhook.png') {
      newGloveNumber = '4';
    } else if (boxingGloveImage == 'assets/punch_leaduppercut.png') {
      newGloveNumber = '5';
    } else if (boxingGloveImage == 'assets/punch_rearuppercut.png') {
      newGloveNumber = '6';
    } else if (boxingGloveImage == 'assets/punch_bodyjab.png') {
      newGloveNumber = '1B';
    } else if (boxingGloveImage == 'assets/punch_bodycross.png') {
      newGloveNumber = '2B';
    } else if (boxingGloveImage == 'assets/punch_leadbodyhook.png') {
      newGloveNumber = '3B';
    } else if (boxingGloveImage == 'assets/punch_rearbodyhook.png') {
      newGloveNumber = '4B';
    } else {
      Logger().i(
        'Something went wrong in changeBoxingNumber...',
      );
      newGloveNumber = '1';
    }

    // Change the state of the provider
    state = newGloveNumber;
  }
}

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
