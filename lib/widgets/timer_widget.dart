import 'package:boksklapps/all_imports.dart';

class TimerWidget extends ConsumerStatefulWidget {
  const TimerWidget({super.key});

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends ConsumerState<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    final double totalTimer = ref.watch(totalTimerProvider);
    final double setTimer = ref.watch(setTimerProvider);
    final double restTimer = ref.watch(restTimerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'TOTAL TIME',
          style: TextStyleUtils.kHeadline3,
        ),
        Text(
          '${totalTimer.toInt()} minutes',
          style: TextStyleUtils.kBodyText,
        ),
        Slider(
          value: ref.watch(totalTimerProvider),
          min: 10.0,
          max: 90.0,
          divisions: 8,
          onChanged: (double newTotalTime) async {
            // User is known, change timer and update Firestore
            if (FirebaseAuth.instance.currentUser != null) {
              await ref
                  .read(totalTimerProvider.notifier)
                  .updateTotalTimer(newTotalTime);
            } else {
              // User is NOT known, show snackbar to user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Sneak Peekers cannot change timers...',
                  ),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                ),
              );
            }
          },
        ),
        const Text(
          'SET TIME',
          style: TextStyleUtils.kHeadline3,
        ),
        Text(
          '${setTimer.toInt()} minutes',
          style: TextStyleUtils.kBodyText,
        ),
        Slider(
          value: setTimer,
          min: 1.0,
          max: 10.0,
          divisions: 9,
          onChanged: (double newSetTime) async {
            // User is known, change timer and update Firestore
            if (FirebaseAuth.instance.currentUser != null) {
              await ref
                  .read(setTimerProvider.notifier)
                  .updateSetTimer(newSetTime);
            } else {
              // User is NOT known, show snackbar to user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Sneak Peekers cannot change timers...',
                  ),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                ),
              );
            }
          },
        ),
        const Text(
          'REST TIME',
          style: TextStyleUtils.kHeadline3,
        ),
        Text(
          '${restTimer.toInt()} seconds',
          style: TextStyleUtils.kBodyText,
        ),
        Slider(
          value: restTimer,
          min: 10.0,
          max: 120.0,
          divisions: 11,
          onChanged: (double newRestTime) async {
            // User is known, change timer and update Firestore
            if (FirebaseAuth.instance.currentUser != null) {
              await ref
                  .read(restTimerProvider.notifier)
                  .updateRestTimer(newRestTime);
            } else {
              // User is NOT known, show snackbar to user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Sneak Peekers cannot change timers...',
                  ),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
