import 'package:boksklapps/all_imports.dart';

class Punch {
  final String punchNumber;
  final String gloveImage;
  final String punchAudio;

  const Punch({
    required this.punchNumber,
    required this.gloveImage,
    required this.punchAudio,
  });
}

// StateProvider that returns a List of Strings, provided by user
final StateProvider<List<Punch>> punchListProvider = StateProvider<List<Punch>>(
  (StateProviderRef<List<Punch>> ref) {
    return <Punch>[];
  },
);

final StateProvider<int> punchIndexProvider = StateProvider<int>(
  (StateProviderRef<int> ref) {
    return 0;
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

class ButtonState {
  final bool isOn;
  final Color color;

  ButtonState(this.isOn, this.color);
}

class ButtonStateNotifier extends StateNotifier<ButtonState> {
  ButtonStateNotifier()
      : super(
          ButtonState(
            false,
            Colors.transparent,
          ),
        );

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
      return isOn
          ? FlexColor.outerSpaceLightPrimaryContainer
          : Colors.transparent;
    }
    // ThemeMode.system + FlexScheme.outerSpace
    else if (ref.watch(themeModeProvider) == ThemeMode.system &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      return isOn
          ? FlexColor.outerSpaceDarkPrimaryContainer
          : Colors.transparent;
    }
    // ThemeMode.dark + FlexScheme.outerSpace
    else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      return isOn
          ? FlexColor.outerSpaceDarkPrimaryContainer
          : Colors.transparent;
    }
    // ThemeMode.light + FlexScheme.money
    else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      return isOn ? FlexColor.moneyLightPrimaryContainer : Colors.transparent;
    }
    // ThemeMode.system + FlexScheme.money
    else if (ref.watch(themeModeProvider) == ThemeMode.system &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      return isOn ? FlexColor.moneyDarkPrimaryContainer : Colors.transparent;
    }
    // ThemeMode.dark + FlexScheme.money
    else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      return isOn ? FlexColor.moneyDarkPrimaryContainer : Colors.transparent;
    }
    // ThemeMode.light + FlexScheme.redWine
    else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      return isOn ? FlexColor.redWineLightPrimaryContainer : Colors.transparent;
    }
    // ThemeMode.system + FlexScheme.redWine
    else if (ref.watch(themeModeProvider) == ThemeMode.system &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      return isOn ? FlexColor.redWineDarkPrimaryContainer : Colors.transparent;
    }
    // ThemeMode.dark + FlexScheme.redWine
    else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      return isOn ? FlexColor.redWineDarkPrimaryContainer : Colors.transparent;
    }
    return Colors.transparent;
  }

  void addPunch1ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '1',
            gloveImage: 'assets/PNG/punch_jab.png',
            punchAudio: 'assets/WAV/dtmf-1.mp3',
          ),
        );
  }

  void addPunch2ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '2',
            gloveImage: 'assets/PNG/punch_cross.png',
            punchAudio: 'assets/WAV/dtmf-2.mp3',
          ),
        );
  }

  void addPunch3ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '3',
            gloveImage: 'assets/PNG/punch_leadhook.png',
            punchAudio: 'assets/WAV/dtmf-3.mp3',
          ),
        );
  }

  void addPunch4ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '4',
            gloveImage: 'assets/PNG/punch_rearhook.png',
            punchAudio: 'assets/WAV/dtmf-4.mp3',
          ),
        );
  }

  void addPunch5ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '5',
            gloveImage: 'assets/PNG/punch_leaduppercut.png',
            punchAudio: 'assets/WAV/dtmf-5.mp3',
          ),
        );
  }

  void addPunch6ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '6',
            gloveImage: 'assets/PNG/punch_rearuppercut.png',
            punchAudio: 'assets/WAV/dtmf-6.mp3',
          ),
        );
  }

  void addPunch1BToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '1B',
            gloveImage: 'assets/PNG/punch_bodyjab.png',
            punchAudio: 'assets/WAV/dtmf-7.mp3',
          ),
        );
  }

  void addPunch2BToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '2B',
            gloveImage: 'assets/PNG/punch_bodycross.png',
            punchAudio: 'assets/WAV/dtmf-8.mp3',
          ),
        );
  }

  void addPunch3BToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '3B',
            gloveImage: 'assets/PNG/punch_leadbodyhook.png',
            punchAudio: 'assets/WAV/dtmf-9.mp3',
          ),
        );
  }

  void addPunch4BToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '4B',
            gloveImage: 'assets/PNG/punch_rearbodyhook.png',
            punchAudio: 'assets/WAV/dtmf-0.mp3',
          ),
        );
  }
}
