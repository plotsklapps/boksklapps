import 'dart:async';

import 'package:boksklapps/all_imports.dart';

class WorkoutScreenDesktop extends ConsumerStatefulWidget {
  const WorkoutScreenDesktop({super.key});

  @override
  WorkoutScreenDesktopState createState() => WorkoutScreenDesktopState();
}

class WorkoutScreenDesktopState extends ConsumerState<WorkoutScreenDesktop> {
  // Create different durations and timers for each purpose
  late Duration totalTimerDuration;
  late Duration setTimerDuration;
  late Duration restTimerDuration;
  late Duration periodicTimerDuration;
  late Timer totalTimer;
  late Timer setTimer;
  late Timer restTimer;
  late Timer periodicTimer;
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
    // This is started within the setTimer
    startTotalTimer();
    startSetTimer();
    // periodicTimer pulsates the punch container and takes
    // a Duration from userTempoDurationProvider
    periodicTimer = Timer.periodic(periodicTimerDuration, (Timer timer) {
      setState(() {
        isVisible = !isVisible;
      });
    });
  }

  @override
  void dispose() {
    // Kill all timers
    totalTimer.cancel();
    setTimer.cancel();
    // Here we check for if the restTimer started
    if (isRestTimerStarted) {
      restTimer.cancel();
    }
    periodicTimer.cancel();
    super.dispose();
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
        appBar: const AppBarWidget(
          title: 'WORKOUT',
        ),
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
                children: <Widget>[
                  const DrawerWidget(),
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
                                  style: TextStyleUtils.kHeadline2,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  StringUtils.kSetTime,
                                  style: TextStyleUtils.kBodyText,
                                ),
                                Text(
                                  setTimerString,
                                  style: TextStyleUtils.kHeadline2,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  StringUtils.kRestTime,
                                  style: TextStyleUtils.kBodyText,
                                ),
                                Text(
                                  restTimerString,
                                  style: TextStyleUtils.kHeadline2,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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
        // Reset totalTimerDuration to original users value
        totalTimerDuration = ref.watch(totalTimerDurationProvider);
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
        // Kill the timer
        setTimer.cancel();
        // Start rest
        startRestTimer();
        // Reset setTimerDuration to original users value
        setTimerDuration = ref.watch(setTimerDurationProvider);
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
      if (restTimerSeconds < 0) {
        // Kill the timer
        restTimer.cancel();
        // Start set
        startSetTimer();
        // Reset restTimerDuration to original users value
        restTimerDuration = ref.watch(restTimerDurationProvider);
      } else {
        restTimerDuration = Duration(seconds: restTimerSeconds);
      }
    });
  }
}
