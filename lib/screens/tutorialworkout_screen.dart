import 'dart:async';

import 'package:boksklapps/widgets/bottombar_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TutorialWorkoutScreen extends StatefulWidget {
  const TutorialWorkoutScreen({super.key});

  @override
  State<TutorialWorkoutScreen> createState() {
    return TutorialWorkoutScreenState();
  }
}

class TutorialWorkoutScreenState extends State<TutorialWorkoutScreen> {
  late Timer warmupTimer;
  late Timer totalTimer;
  late Timer setTimer;
  late Timer restTimer;

  Duration warmupTimeLeft = const Duration(minutes: 5);
  Duration totalTimeLeft = const Duration(minutes: 30);
  Duration setTimeLeft = const Duration(minutes: 2);
  Duration restTimeLeft = const Duration(seconds: 30);

  bool totalTimerRunning = false;

  @override
  void initState() {
    super.initState();
    startWarmupTimer();
    startTotalTimer();
  }

  void startWarmupTimer() {
    warmupTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (warmupTimeLeft.inSeconds == 0) {
        timer.cancel();
        startSetTimer();
      } else {
        setState(() {
          warmupTimeLeft -= const Duration(seconds: 1);
        });
      }
    });
  }

  void startTotalTimer() {
    totalTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      totalTimerRunning = true;
      // When the total time is up, cancel all timers.
      if (totalTimeLeft.inSeconds == 0) {
        totalTimerRunning = false;
        timer.cancel();
        setTimer.cancel();
        restTimer.cancel();
      } else {
        setState(() {
          totalTimeLeft -= const Duration(seconds: 1);
        });
      }
    });
  }

  void startSetTimer() {
    setTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      // When the set time is up, start the rest time IF the total
      // time is not up.
      if (setTimeLeft.inSeconds == 0) {
        timer.cancel();
        setTimeLeft = const Duration(minutes: 2);
        if (totalTimeLeft.inSeconds > 0) {
          startRestTimer();
        }
      } else {
        setState(() {
          setTimeLeft -= const Duration(seconds: 1);
        });
      }
    });
  }

  void startRestTimer() {
    restTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      // When the rest time is up, start the set time IF the total
      // time is not up.
      if (restTimeLeft.inSeconds == 0) {
        timer.cancel();
        restTimeLeft = const Duration(seconds: 30);
        if (totalTimeLeft.inSeconds > 0) {
          startSetTimer();
        }
      } else {
        setState(() {
          restTimeLeft -= const Duration(seconds: 1);
        });
      }
    });
  }

  // Prettify the timer display
  String formatDuration(Duration duration) {
    final String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TUTORIAL WORKOUT'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: const FaIcon(FontAwesomeIcons.mugHot),
                            title: Text(formatDuration(warmupTimeLeft)),
                            subtitle: const Text('WARM UP'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: const FaIcon(FontAwesomeIcons.solidClock),
                            title: Text(formatDuration(totalTimeLeft)),
                            subtitle: const Text('TOTAL TIME'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: const FaIcon(FontAwesomeIcons.stopwatch),
                            title:
                                Text(formatDuration(setTimeLeft)), // add actual
                            // timer
                            // here
                            subtitle: const Text('SET TIME'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: const FaIcon(FontAwesomeIcons.bed),
                            title: Text(formatDuration(restTimeLeft)),
                            subtitle: const Text('REST TIME'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.dumbbell),
                            title: Text('Exercise'),
                            subtitle: Text('Pushups'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) {
                return const TutorialWorkoutScreen();
              },
            ),
          );
        },
        child: totalTimerRunning
            ? const FaIcon(FontAwesomeIcons.pause)
            : const FaIcon(FontAwesomeIcons.play),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomBarHomeScreen(),
    );
  }
}
