import 'package:audioplayers/audioplayers.dart';
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      Audio.audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      Audio.audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      Audio.audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      Audio.audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
    });
  }

  Future<void> playOneBell() async {
    // Play 'one bell' Audio
    await Audio.audioPlayer.play(AssetSource(SoundUtils.kOneBell)).then((_) {
      Audio.audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
    });
  }

  Future<void> playThreeBell() async {
    // Play 'three bell' Audio
    await Audio.audioPlayer.play(AssetSource(SoundUtils.kThreeBell)).then((_) {
      Audio.audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
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
    await Audio.audioPlayer.play(AssetSource(punchAudio)).then((_) {
      audioPlayer.onPlayerComplete.listen((_) {
        // Dispose audio player
        disposeAudioPlayer();
      });
    });
  }
}
