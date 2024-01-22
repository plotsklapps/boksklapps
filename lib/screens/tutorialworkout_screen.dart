import 'dart:async';

import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
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
  late WorkoutTimer workoutTimer;

  // Durations for the UI to display.
  Duration warmupTimeLeft = const Duration(minutes: 1);
  Duration totalTimeLeft = const Duration(minutes: 27);
  Duration setTimeLeft = const Duration(minutes: 1);
  Duration restTimeLeft = const Duration(seconds: 30);

  // Flag to indicate which timer is running.
  bool totalTimerRunning = false;
  bool warmupTimerRunning = false;
  bool setTimerRunning = false;
  bool restTimerRunning = false;

  // Number of sets remaining in the workout.
  int numberOfSets = 15;

  @override
  void initState() {
    super.initState();
    initializeTimer();
  }

  // Initialize and start the workout timer.
  void initializeTimer() {
    workoutTimer = WorkoutTimer(
      onTotalTimeLeft: (Duration timeLeft) {
        setState(() {
          totalTimeLeft = timeLeft;
          totalTimerRunning = timeLeft > Duration.zero;
        });
      },
      onWarmupTimeLeft: (Duration timeLeft) {
        setState(() {
          warmupTimeLeft = timeLeft;
          warmupTimerRunning = timeLeft > Duration.zero;
        });
      },
      onSetTimeLeft: (Duration timeLeft) {
        setState(() {
          setTimeLeft = timeLeft;
          setTimerRunning = timeLeft > Duration.zero;
        });
      },
      onRestTimeLeft: (Duration timeLeft) {
        setState(() {
          restTimeLeft = timeLeft;
          restTimerRunning = timeLeft > Duration.zero;
        });
      },
      onSetsCompleted: (int setsCompleted) {
        setState(() {
          numberOfSets = 15 - setsCompleted;
        });
      },
      onWorkoutComplete: () {
        setState(() {
          totalTimerRunning = false;
        });
      },
    );
    workoutTimer.startTimer();
    setState(() {
      totalTimerRunning = true;
    });
  }

  @override
  void dispose() {
    workoutTimer.cancelTimer();
    super.dispose();
  }

  // Format Duration to a more readable string format.
  String formatDuration(Duration duration) {
    // Ensure that duration is never negative
    final int totalSeconds = duration.inSeconds >= 0 ? duration.inSeconds : 0;

    final String minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final String seconds = (totalSeconds % 60).toString().padLeft(2, '0');
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
                      color: warmupTimerRunning ? Colors.green : null,
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
                      color: totalTimerRunning ? Colors.green : null,
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
                      color: setTimerRunning ? Colors.green : null,
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
                      color: restTimerRunning ? Colors.green : null,
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
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text('NUMBER OF SETS LEFT:', style: TextUtils.fontL),
                  Text(numberOfSets.toString(), style: TextUtils.fontL),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (totalTimerRunning) {
            workoutTimer
                .pauseTimer(); // Implement pauseTimer method in WorkoutTimer
            setState(() => totalTimerRunning = false);
          } else {
            workoutTimer
                .resumeTimer(); // Implement resumeTimer method in WorkoutTimer
            setState(() => totalTimerRunning = true);
          }
        },
        child: totalTimerRunning
            ? const FaIcon(FontAwesomeIcons.pause)
            : const FaIcon(FontAwesomeIcons.play),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomBar(),
    );
  }
}

// Enum representing the different phases of the workout.
enum WorkoutPhase { warmup, set, rest, done }

// This class manages the workout timer logic.
class WorkoutTimer {
  // Constructor requires callback functions for state updates.
  WorkoutTimer({
    required this.onWarmupTimeLeft,
    required this.onSetTimeLeft,
    required this.onRestTimeLeft,
    required this.onTotalTimeLeft,
    required this.onSetsCompleted,
    required this.onWorkoutComplete,
  });
  // Callbacks for state updates provided by the UI.
  void Function(Duration) onWarmupTimeLeft;
  void Function(Duration) onSetTimeLeft;
  void Function(Duration) onRestTimeLeft;
  void Function(Duration) onTotalTimeLeft;
  void Function(int) onSetsCompleted;
  void Function() onWorkoutComplete;

  // Timer used for periodic updates.
  late Timer _timer;

  // Durations for different phases of the workout.
  Duration warmupDuration = const Duration(minutes: 1);
  Duration setDuration = const Duration(minutes: 1);
  Duration restDuration = const Duration(seconds: 30);
  Duration totalTime = const Duration(minutes: 27);

  // Track the TOTAL time elapsed since the first timer tick.
  Duration _totalTimeElapsed = Duration.zero;
  // Track the time elapsed since that specific timer started.
  Duration _timeElapsed = Duration.zero;
  // Track the number of sets completed.
  int _setsCompleted = 0;
  // Total number of sets in the workout.
  final int _totalSets = 15;

  // Current phase of the workout.
  WorkoutPhase _currentPhase = WorkoutPhase.warmup;
  // Flag to track if the timer is paused.
  bool _isPaused = false;

  // Start the workout timer with a periodic callback.
  void startTimer() {
    _isPaused = false;
    _timer = Timer.periodic(const Duration(seconds: 1), _timerTick);
  }

  // Timer tick callback, called every second.
  void _timerTick(Timer timer) {
    // Skip the timer tick if the timer is paused.
    if (_isPaused) {
      return;
    }

    // Increment the elapsed time.
    _timeElapsed += const Duration(seconds: 1);
    _totalTimeElapsed += const Duration(seconds: 1);

    // Calculate the total time left and invoke the corresponding callback.
    final Duration totalTimeLeft = totalTime - _totalTimeElapsed;
    onTotalTimeLeft(totalTimeLeft);

    // Handle the logic based on the current phase of the workout.
    if (_currentPhase == WorkoutPhase.warmup) {
      // Calculate the remaining warmup time.
      final Duration warmupTimeLeft = warmupDuration - _timeElapsed;
      onWarmupTimeLeft(warmupTimeLeft);
      // Transition to set phase when warmup is complete.
      if (warmupTimeLeft.inSeconds <= 0) {
        _currentPhase = WorkoutPhase.set;
        _timeElapsed = Duration.zero;
      }
      onWarmupTimeLeft(warmupTimeLeft);
    } else if (_currentPhase == WorkoutPhase.set) {
      // Calculate the remaining set time.
      final int setElapsedSeconds = _timeElapsed.inSeconds;
      Duration setTimeLeft =
          Duration(seconds: setDuration.inSeconds - setElapsedSeconds);
      // Ensure we never have negative set time.
      if (setTimeLeft.inSeconds < 0) {
        setTimeLeft = Duration.zero;
      }
      onSetTimeLeft(setTimeLeft);
      // Transition to rest phase or end when set is complete.
      if (setTimeLeft.inSeconds <= 0) {
        _setsCompleted++;

        // Call the callback with the updated number of sets completed.
        onSetsCompleted(_setsCompleted);

        if (_setsCompleted < _totalSets) {
          _currentPhase = WorkoutPhase.rest;
          _timeElapsed = Duration.zero;
        } else {
          _currentPhase = WorkoutPhase.done;
        }
      }
    } else if (_currentPhase == WorkoutPhase.rest) {
      // Calculate the remaining rest time.
      final int restElapsedSeconds = _timeElapsed.inSeconds;
      Duration restTimeLeft =
          Duration(seconds: restDuration.inSeconds - restElapsedSeconds);
      // Ensure we never have negative rest time.
      if (restTimeLeft.inSeconds < 0) {
        restTimeLeft = Duration.zero;
      }
      onRestTimeLeft(restTimeLeft);
      // Transition back to set phase when rest is complete.
      if (restTimeLeft.inSeconds <= 0) {
        _currentPhase = WorkoutPhase.set;
        _timeElapsed = Duration.zero;
      }
    } else if (_currentPhase == WorkoutPhase.done) {
      // Stop the timer and invoke the workout complete callback.
      timer.cancel();
      onWorkoutComplete();
    }
  }

  // Pause the workout timer.
  void pauseTimer() {
    _isPaused = true;
  }

  // Resume the workout timer.
  void resumeTimer() {
    _isPaused = false;
  }

  // Cancel the workout timer.
  void cancelTimer() {
    _timer.cancel();
  }
}
