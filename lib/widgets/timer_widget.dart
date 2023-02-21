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
    double setTimer = ref.watch(setTimerProvider);
    double restTimer = ref.watch(restTimerProvider);
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
          onChanged: (double newTotalTime) {
            ref
                .read(totalTimerProvider.notifier)
                .updateTotalTimer(newTotalTime);
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
          onChanged: (double newSetTime) {
            ref.read(setTimerProvider.notifier).updateSetTimer(newSetTime);
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
          onChanged: (double newRestTime) {
            ref.read(restTimerProvider.notifier).updateRestTimer(newRestTime);
          },
        ),
      ],
    );
  }
}
