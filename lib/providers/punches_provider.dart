import 'package:boksklapps/all_imports.dart';

// StateProvider that returns a List of Strings, provided by user
final StateProvider<List<String>> punchListProvider =
    StateProvider<List<String>>(
  (StateProviderRef<List<String>> ref) {
    return <String>[];
  },
);

// List that returns boxingGloveImages as String
final List<String> boxingGloveImages = <String>[
  'assets/PNG/punch_jab.png',
  'assets/PNG/punch_cross.png',
  'assets/PNG/punch_leadhook.png',
  'assets/PNG/punch_rearhook.png',
  'assets/PNG/punch_leaduppercut.png',
  'assets/PNG/punch_rearuppercut.png',
  'assets/PNG/punch_bodyjab.png',
  'assets/PNG/punch_bodycross.png',
  'assets/PNG/punch_leadbodyhook.png',
  'assets/PNG/punch_rearbodyhook.png',
];

// Method that returns a boxingGloveImage as String, depending
// on the punch that is passed as a String
String getBoxingGloveImage(String punch) {
  if (punch == '1') {
    return 'assets/PNG/punch_jab.png';
  } else if (punch == '2') {
    return 'assets/PNG/punch_cross.png';
  } else if (punch == '3') {
    return 'assets/PNG/punch_leadhook.png';
  } else if (punch == '4') {
    return 'assets/PNG/punch_rearhook.png';
  } else if (punch == '5') {
    return 'assets/PNG/punch_leaduppercut.png';
  } else if (punch == '6') {
    return 'assets/PNG/punch_rearuppercut.png';
  } else if (punch == '1B') {
    return 'assets/PNG/punch_bodyjab.png';
  } else if (punch == '2B') {
    return 'assets/PNG/punch_bodycross.png';
  } else if (punch == '3B') {
    return 'assets/PNG/punch_leadbodyhook.png';
  } else if (punch == '4B') {
    return 'assets/PNG/punch_rearbodyhook.png';
  } else {
    throw Exception('Invalid punch: $punch');
  }
}

final boxingGloveProvider = Provider<List<String>>((ref) {
  // Map each punch to the corresponding boxing glove image
  final List<String> gloves =
      ref.watch(punchListProvider).map(getBoxingGloveImage).toList();

  return gloves;
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
