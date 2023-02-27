import 'dart:async';

import 'package:boksklapps/all_imports.dart';

class WorkoutScreenMobile extends ConsumerStatefulWidget {
  const WorkoutScreenMobile({super.key});

  @override
  WorkoutScreenMobileState createState() => WorkoutScreenMobileState();
}

class WorkoutScreenMobileState extends ConsumerState<WorkoutScreenMobile> {
  // Create different durations and timers for each purpose
  late Duration totalTimerDuration;
  // originalSetTimerDuration stays the same the whole workout
  late Duration originalSetTimerDuration;
  // setTimerDuration goes to 0 and resets to originalSetTimerDuration
  late Duration setTimerDuration;
  late Duration restTimerDuration;
  late Timer totalTimer;
  late Timer setTimer;
  late Timer restTimer;
  late Timer periodicTimer;
  // Create bool to show punch or not
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    // Initialize the durations
    totalTimerDuration = ref.read(totalTimerDurationProvider);
    originalSetTimerDuration = ref.read(setTimerDurationProvider);
    setTimerDuration = ref.read(setTimerDurationProvider);
    restTimerDuration = ref.read(restTimerDurationProvider);
    // Start the timers, but NOT the restTimer!
    // This is started within the setTimer
    startTotalTimer();
    startSetTimer();
    // periodicTimer pulsates the punch container
    periodicTimer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        isVisible = !isVisible;
      });
    });
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

  void startSetTimer() {
    setTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      return setTimerCountdown();
    });
  }

  void startRestTimer() {
    restTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      return restTimerCountdown();
    });
  }

  void totalTimerCountdown() {
    const int reduceSecondsBy = 1;
    setState(() {
      final int totalTimerSeconds =
          totalTimerDuration.inSeconds - reduceSecondsBy;
      if (totalTimerSeconds == 0) {
        totalTimer.cancel();
      } else {
        totalTimerDuration = Duration(seconds: totalTimerSeconds);
      }
    });
  }

  void setTimerCountdown() {
    const int reduceSecondsBy = 1;
    setState(() {
      final int setTimerSeconds = setTimerDuration.inSeconds - reduceSecondsBy;
      if (setTimerSeconds < 0) {
        setTimer.cancel();
        startRestTimer();
      } else {
        setTimerDuration = Duration(seconds: setTimerSeconds);
      }
    });
  }

  void restTimerCountdown() {
    const int reduceSecondsBy = 1;
    setState(() {
      final int restTimerSeconds =
          restTimerDuration.inSeconds - reduceSecondsBy;
      if (restTimerSeconds < 0) {
        restTimer.cancel();
        ref.read(setTimerDurationProvider.notifier).state =
            originalSetTimerDuration;
        startSetTimer();
      } else {
        restTimerDuration = Duration(seconds: restTimerSeconds);
      }
    });
  }

  @override
  void dispose() {
    totalTimer.cancel();
    setTimer.cancel();
    restTimer.cancel();
    periodicTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Column>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Total Time',
                            style: TextStyleUtils.kBodyText,
                          ),
                          Text(
                            totalTimerString,
                            style: TextStyleUtils.kHeadline3,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Set Time',
                            style: TextStyleUtils.kBodyText,
                          ),
                          Text(
                            setTimerString,
                            style: TextStyleUtils.kHeadline3,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Rest Time',
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
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyleUtils.kHeadline1,
                        ),
                      ),
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
}
