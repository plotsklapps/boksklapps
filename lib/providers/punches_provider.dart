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
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-1.mp3?'
                'alt=media&token=1135e45f-3289-404d-91f8-f41a7920bb8e',
          ),
        );
  }

  void addPunch2ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '2',
            gloveImage: 'assets/PNG/punch_cross.png',
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-2.mp3?'
                'alt=media&token=c6b4ef41-beed-4b34-8223-ff0f915c2eff',
          ),
        );
  }

  void addPunch3ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '3',
            gloveImage: 'assets/PNG/punch_leadhook.png',
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-3.mp3?'
                'alt=media&token=5a7dc74e-cbc1-4f8e-b800-458657cbe65c',
          ),
        );
  }

  void addPunch4ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '4',
            gloveImage: 'assets/PNG/punch_rearhook.png',
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-4.mp3?'
                'alt=media&token=e34811f2-f43a-4fec-9265-d893d32c379d',
          ),
        );
  }

  void addPunch5ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '5',
            gloveImage: 'assets/PNG/punch_leaduppercut.png',
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-5.mp3?'
                'alt=media&token=ecc357ff-a879-47cb-828c-825e1cc1852f',
          ),
        );
  }

  void addPunch6ToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '6',
            gloveImage: 'assets/PNG/punch_rearuppercut.png',
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-6.mp3?'
                'alt=media&token=ab544c92-8654-4693-a942-e9bb828dc447',
          ),
        );
  }

  void addPunch1BToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '1B',
            gloveImage: 'assets/PNG/punch_bodyjab.png',
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-7.mp3?'
                'alt=media&token=c1ea264b-bae1-4cdb-a9cf-6f1050c6f53b',
          ),
        );
  }

  void addPunch2BToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '2B',
            gloveImage: 'assets/PNG/punch_bodycross.png',
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-8.mp3?'
                'alt=media&token=e5077ec4-d6a4-4d5b-9f2b-ce7b642a3c6d',
          ),
        );
  }

  void addPunch3BToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '3B',
            gloveImage: 'assets/PNG/punch_leadbodyhook.png',
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-9.mp3?'
                'alt=media&token=ee5f18be-cfe5-423e-b3ee-e5c19fcb549f',
          ),
        );
  }

  void addPunch4BToList(WidgetRef ref) {
    ref.read(punchListProvider.notifier).state.add(
          const Punch(
            punchNumber: '4B',
            gloveImage: 'assets/PNG/punch_rearbodyhook.png',
            punchAudio: 'https://firebasestorage.googleapis.com/v0/b/'
                'boksklapps.appspot.com/o/WAV%2Fdtmf-0.mp3?'
                'alt=media&token=cf53f5ea-ecc1-4759-9ddf-dee1fe75b18a',
          ),
        );
  }
}
