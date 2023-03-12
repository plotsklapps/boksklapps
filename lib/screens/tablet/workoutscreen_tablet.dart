import 'dart:async';

import 'package:boksklapps/all_imports.dart';

class WorkoutScreenTablet extends ConsumerStatefulWidget {
  const WorkoutScreenTablet({super.key});

  @override
  WorkoutScreenTabletState createState() => WorkoutScreenTabletState();
}

class WorkoutScreenTabletState extends ConsumerState<WorkoutScreenTablet> {
  // Create different durations and timers for each purpose
  late Duration totalTimerDuration;
  late Duration setTimerDuration;
  late Duration restTimerDuration;
  late Duration periodicTimerDuration;
  late Timer totalTimer;
  late Timer setTimer;
  late Timer restTimer;
  late Timer periodicTimer;
  // Create AudioPlayer instance
  final AudioPlayer audioPlayer = AudioPlayer();
  // Create bool to show punch or not
  bool isVisible = true;
  // If restTimer is not started, it cannot be cancelled
  // so is RestTimerStarted checks it to prevent bugs
  bool isRestTimerStarted = false;

  @override
  void initState() {
    super.initState();
    // TODO: Initialize a prepareTimer as well
    // Initialize the durations
    totalTimerDuration = ref.read(totalTimerDurationProvider);
    setTimerDuration = ref.read(setTimerDurationProvider);
    restTimerDuration = ref.read(restTimerDurationProvider);
    periodicTimerDuration = ref.read(userTempoDurationProvider);
    // Start the timers, but NOT the restTimer!
    // The restTimer is started within the setTimer
    startTotalTimer();
    startSetTimer();
    startPeriodicTimer();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    // Kill all timers
    totalTimer.cancel();
    setTimer.cancel();
    periodicTimer.cancel();
    // Here we check for if the restTimer started
    if (isRestTimerStarted) {
      restTimer.cancel();
    }
    await audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Looong piece of code to prettify Duration to String
    final String totalTimerString =
        '${totalTimerDuration.inMinutes.toString().padLeft(2, '0')}:'
        '${(totalTimerDuration.inSeconds % 60).toString().padLeft(2, '0')}';
    final String setTimerString =
        '${setTimerDuration.inMinutes.toString().padLeft(2, '0')}:'
        '${(setTimerDuration.inSeconds % 60).toString().padLeft(2, '0')}';
    final String restTimerString =
        '${restTimerDuration.inMinutes.toString().padLeft(2, '0')}:'
        '${(restTimerDuration.inSeconds % 60).toString().padLeft(2, '0')}';
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(title: 'WORKOUT'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              24.0,
            ),

            // Wrap the Column() in a SizedBox() to set the total height
            // at 85% of the screen height so that the SingleChildScrollView()
            // won't affect any of the widgets inside the Column()
            // and the keyboard can easily pop up without any issues
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        GetShitDoneWidget(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Column>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  StringUtils.kTotalTime,
                                  style: TextStyleUtils.kBodyText,
                                ),
                                Text(
                                  totalTimerString,
                                  style: TextStyleUtils.kHeadline3,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  StringUtils.kSetTime,
                                  style: TextStyleUtils.kBodyText,
                                ),
                                Text(
                                  setTimerString,
                                  style: TextStyleUtils.kHeadline3,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  StringUtils.kRestTime,
                                  style: TextStyleUtils.kBodyText,
                                ),
                                Text(
                                  restTimerString,
                                  style: TextStyleUtils.kHeadline3,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 64),
                        WorkoutPunchWidget(
                          isVisible: isVisible,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startTotalTimer() {
    // Total time and set time should start at the same time
    // (AFTER prepare time is over, which is a TODO).
    // Set time should be reset when rest time starts.
    // Rest time should start when set time ends.
    // Set time should reset and start when rest time ends.
    // Repeat until total time is up.
    totalTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      return totalTimerCountdown();
    });
  }

  void totalTimerCountdown() {
    const int reduceSecondsBy = 1;
    setState(() {
      final int totalTimerSeconds =
          totalTimerDuration.inSeconds - reduceSecondsBy;
      if (totalTimerSeconds < 0) {
        // Kill the timer
        totalTimer.cancel();
        setTimer.cancel();
        restTimer.cancel();
        periodicTimer.cancel();
        // Reset totalTimerDuration to original users value
        totalTimerDuration = ref.watch(totalTimerDurationProvider);
        setTimerDuration = ref.watch(setTimerDurationProvider);
        restTimerDuration = ref.watch(restTimerDurationProvider);
        periodicTimerDuration = ref.read(userTempoDurationProvider);
        // TODO: Show CONFETTI ofcourse
      } else {
        totalTimerDuration = Duration(seconds: totalTimerSeconds);
      }
    });
  }

  void startSetTimer() {
    setTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      return setTimerCountdown();
    });
  }

  void setTimerCountdown() {
    const int reduceSecondsBy = 1;
    setState(() {
      final int setTimerSeconds = setTimerDuration.inSeconds - reduceSecondsBy;
      if (setTimerSeconds < 0) {
        // Kill the setTimer and periodicTimer
        setTimer.cancel();
        periodicTimer.cancel();
        // Play sound
        unawaited(playThreeBell());
        // Start rest
        startRestTimer();
        // Reset setTimerDuration to original users value
        setTimerDuration = ref.watch(setTimerDurationProvider);
        //Play sound
        unawaited(delayedPlayRestAudio());
      } else {
        setTimerDuration = Duration(seconds: setTimerSeconds);
      }
    });
  }

  void startRestTimer() {
    restTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      return restTimerCountdown();
    });
  }

  void restTimerCountdown() {
    const int reduceSecondsBy = 1;
    isRestTimerStarted = true;
    setState(() {
      final int restTimerSeconds =
          restTimerDuration.inSeconds - reduceSecondsBy;
      if (restTimerSeconds == 1) {
        // Play sound
        unawaited(playPrepareForTheNextSetAudio());
      }
      if (restTimerSeconds < 0) {
        // Play sound
        unawaited(playOneBell());
        // Kill the restTimer
        restTimer.cancel();
        // Start setTimer and periodicTimer
        startSetTimer();
        startPeriodicTimer();
        // Reset restTimerDuration to original users value
        restTimerDuration = ref.watch(restTimerDurationProvider);
      } else {
        restTimerDuration = Duration(seconds: restTimerSeconds);
      }
    });
  }

  void startPeriodicTimer() {
    periodicTimer = Timer.periodic(periodicTimerDuration, (_) {
      setState(() {
        isVisible = !isVisible;
      });
    });
  }

  Future<void> delayedPlayRestAudio() async {
    // Sets a three second delay before playing the rest audio
    // used after three bell audio (so they won't overlap)
    Future<void>.delayed(const Duration(seconds: 3), playRestAudio);
  }

  Future<void> playRestAudio() async {
    // Play 'rest' Audio
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kRestElli;
    } else {
      punchAudio = SoundUtils.kRestArnold;
    }
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playGoodJobAudio() async {
    // Play 'good job' Audio
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kGoodJobElli;
    } else {
      punchAudio = SoundUtils.kGoodJobArnold;
    }
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playKeepItUpAudio() async {
    // Play ' keep it up' Audio
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kKeepItUpElli;
    } else {
      punchAudio = SoundUtils.kKeepItUpArnold;
    }
    await audioPlayer.setAsset(punchAudio).then((_) {
      audioPlayer.play();
    });
  }

  Future<void> playPrepareForTheNextSetAudio() async {
    // Play 'prepare for the next set' Audio
    final int punchAudioInt = ref.watch(userSoundProvider);
    String punchAudio;
    if (punchAudioInt == 0) {
      punchAudio = SoundUtils.kPrepareForTheNextSetElli;
    } else {
      punchAudio = SoundUtils.kPrepareForTheNextSetArnold;
    }
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
}
