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

  ButtonState(
    this.isOn,
    this.color,
  );
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
          : const Color(0xFFECF3F6);
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
      return isOn
          ? FlexColor.moneyLightPrimaryContainer
          : const Color(0xFFECF4ED);
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
      return isOn
          ? FlexColor.redWineLightPrimaryContainer
          : const Color(0xFFFAEEF3);
    }
    // ThemeMode.system + FlexScheme.redWine
    else if (ref.watch(themeModeProvider) == ThemeMode.system &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      return isOn ? FlexColor.redWineDarkPrimaryContainer : Colors.transparent;
    }
    // ThemeMode.dark + FlexScheme.redWine
    else {
      return isOn ? FlexColor.redWineDarkPrimaryContainer : Colors.transparent;
    }
  }

  void addPunch1ToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch1Ellie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch1Arnold;
    } else {
      punchAudio = SoundUtils.kPunch1DTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '1',
            gloveImage: 'assets/PNG/punch_jab.png',
            punchAudio: punchAudio,
          ),
        );
  }

  void addPunch2ToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch2Ellie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch2Arnold;
    } else {
      punchAudio = SoundUtils.kPunch2DTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '2',
            gloveImage: 'assets/PNG/punch_cross.png',
            punchAudio: punchAudio,
          ),
        );
  }

  void addPunch3ToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch3Ellie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch3Arnold;
    } else {
      punchAudio = SoundUtils.kPunch3DTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '3',
            gloveImage: 'assets/PNG/punch_leadhook.png',
            punchAudio: punchAudio,
          ),
        );
  }

  void addPunch4ToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch4Ellie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch4Arnold;
    } else {
      punchAudio = SoundUtils.kPunch4DTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '4',
            gloveImage: 'assets/PNG/punch_rearhook.png',
            punchAudio: punchAudio,
          ),
        );
  }

  void addPunch5ToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch5Ellie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch5Arnold;
    } else {
      punchAudio = SoundUtils.kPunch5DTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '5',
            gloveImage: 'assets/PNG/punch_leaduppercut.png',
            punchAudio: punchAudio,
          ),
        );
  }

  void addPunch6ToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch6Ellie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch6Arnold;
    } else {
      punchAudio = SoundUtils.kPunch6DTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '6',
            gloveImage: 'assets/PNG/punch_rearuppercut.png',
            punchAudio: punchAudio,
          ),
        );
  }

  void addPunch1BToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch1BEllie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch1BArnold;
    } else {
      punchAudio = SoundUtils.kPunch1BDTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '1B',
            gloveImage: 'assets/PNG/punch_bodyjab.png',
            punchAudio: punchAudio,
          ),
        );
  }

  void addPunch2BToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch2BEllie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch2BArnold;
    } else {
      punchAudio = SoundUtils.kPunch2BDTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '2B',
            gloveImage: 'assets/PNG/punch_bodycross.png',
            punchAudio: punchAudio,
          ),
        );
  }

  void addPunch3BToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch3BEllie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch3BArnold;
    } else {
      punchAudio = SoundUtils.kPunch3BDTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '3B',
            gloveImage: 'assets/PNG/punch_leadbodyhook.png',
            punchAudio: punchAudio,
          ),
        );
  }

  void addPunch4BToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch4BEllie;
    } else if (punchAudioInt == 1) {
      punchAudio = SoundUtils.kPunch4BArnold;
    } else {
      punchAudio = SoundUtils.kPunch4BDTMF;
    }
    ref.read(punchListProvider.notifier).state.add(
          Punch(
            punchNumber: '4B',
            gloveImage: 'assets/PNG/punch_rearbodyhook.png',
            punchAudio: punchAudio,
          ),
        );
  }
}
