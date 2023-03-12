import 'package:boksklapps/all_imports.dart';

final Provider<Audio> audioProvider = Provider<Audio>((ProviderRef<Audio> ref) {
  return Audio(ref: ref);
});

class Audio {
  final ProviderRef<Audio> ref;
  Audio({required this.ref});
  // Create ONE static AudioPlayer() instance, available
  // globally to all widgets in the app. This makes sure
  // that the audio player is not re-created every time
  static AudioPlayer audioPlayer = AudioPlayer();

  void disposeAudioPlayer() {
    Future<void>.microtask(() async {
      await audioPlayer.dispose();
    });
  }

  Future<void> delayedPlayRestAudio() async {
    // Sets a three second delay before playing the rest audio
    // used after three bell audio (so they won't overlap)
    Future<void>.delayed(const Duration(seconds: 3), playRestAudio);
  }

  Future<void> playRestAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kRestElli;
    } else {
      punchAudio = SoundUtils.kRestArnold;
    }
    // Play 'rest' audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playGoodJobAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kGoodJobElli;
    } else {
      punchAudio = SoundUtils.kGoodJobArnold;
    }
    // Play 'good job' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playKeepItUpAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kKeepItUpElli;
    } else {
      punchAudio = SoundUtils.kKeepItUpArnold;
    }
    // Play ' keep it up' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playPrepareForTheNextSetAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPrepareForTheNextSetElli;
    } else {
      punchAudio = SoundUtils.kPrepareForTheNextSetArnold;
    }
    // Play 'prepare for the next set' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playOneBell() async {
    // Play 'one bell' Audio
    await audioPlayer.setAsset(SoundUtils.kOneBell).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playThreeBell() async {
    // Play 'three bell' Audio
    await audioPlayer.setAsset(SoundUtils.kThreeBell).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playJabAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchJabElli;
    } else {
      punchAudio = SoundUtils.kPunchJabArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playCrossAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchCrossElli;
    } else {
      punchAudio = SoundUtils.kPunchCrossArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playLeadHookAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchLeadHookElli;
    } else {
      punchAudio = SoundUtils.kPunchLeadHookArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playRearHookAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchRearHookElli;
    } else {
      punchAudio = SoundUtils.kPunchRearHookArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playLeadUppercutAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchLeadUppercutElli;
    } else {
      punchAudio = SoundUtils.kPunchLeadUppercutArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playRearUppercutAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchRearUppercutElli;
    } else {
      punchAudio = SoundUtils.kPunchRearUppercutArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playBodyJabAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchBodyJabElli;
    } else {
      punchAudio = SoundUtils.kPunchBodyJabArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playBodyCrossAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchBodyCrossElli;
    } else {
      punchAudio = SoundUtils.kPunchBodyCrossArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playLeadBodyHookAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchLeadBodyHookElli;
    } else {
      punchAudio = SoundUtils.kPunchLeadBodyHookArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playRearBodyHookAudio() async {
    // Look for correct voice
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPunchRearBodyHookElli;
    } else {
      punchAudio = SoundUtils.kPunchRearBodyHookArnold;
    }
    // Play 'jab' Audio
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }
}
