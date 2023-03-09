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

  ButtonState(
    this.isOn,
  );
}

class ButtonStateNotifier extends StateNotifier<ButtonState> {
  ButtonStateNotifier()
      : super(
          ButtonState(
            false,
          ),
        );

  void toggle(WidgetRef ref) {
    state = ButtonState(!state.isOn);
  }

  void addPunch1ToList(WidgetRef ref) {
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunch1Elli;
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
      punchAudio = SoundUtils.kPunch2Elli;
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
      punchAudio = SoundUtils.kPunch3Elli;
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
      punchAudio = SoundUtils.kPunch4Elli;
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
      punchAudio = SoundUtils.kPunch5Elli;
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
      punchAudio = SoundUtils.kPunch6Elli;
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
      punchAudio = SoundUtils.kPunch1BElli;
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
      punchAudio = SoundUtils.kPunch2BElli;
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
      punchAudio = SoundUtils.kPunch3BElli;
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
      punchAudio = SoundUtils.kPunch4BElli;
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
