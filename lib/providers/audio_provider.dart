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
      // Dispose audio player
      disposeAudioPlayer();
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
      // Dispose audio player
      disposeAudioPlayer();
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
      // Dispose audio player
      disposeAudioPlayer();
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
      // Dispose audio player
      disposeAudioPlayer();
    });
  }

  Future<void> playOneBell() async {
    // Play 'one bell' Audio
    await Audio.audioPlayer.play(AssetSource(SoundUtils.kOneBell)).then((_) {
      // Dispose audio player
      disposeAudioPlayer();
    });
  }

  Future<void> playThreeBell() async {
    // Play 'three bell' Audio
    await Audio.audioPlayer.play(AssetSource(SoundUtils.kThreeBell)).then((_) {
      // Dispose audio player
      disposeAudioPlayer();
    });
  }
}
