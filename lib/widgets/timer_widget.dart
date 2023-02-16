import '../all_imports.dart';

/// TimerWidget class
class TimerWidget extends ConsumerWidget {
  /// TimerWidget constructor
  const TimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch timer states
    final Duration totalTime = ref.watch(totalTimeProvider);
    final Duration setTime = ref.watch(setTimeProvider);
    final Duration restTime = ref.watch(restTimeProvider);

    // Format the timer states
    String format(Duration d) {
      return d.toString().split('.').first.padLeft(8, '0');
    }

    // Set formatted timer states in new variables
    final String formattedTotalTime = format(totalTime);
    final String formattedSetTime = format(setTime);
    final String formattedRestTime = format(restTime);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        32,
        0,
        32,
        32,
      ),
      child: Column(
        children: <Row>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Column>[
              Column(
                children: const <Text>[
                  Text(
                    'TOTAL TIME',
                    style: TextStyleUtils.kHeadline3,
                  ),
                  Text(
                    'in minutes',
                    style: TextStyleUtils.kBodyText,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  ref.read(totalTimeProvider.notifier).state -= const Duration(
                    minutes: 1,
                  );
                },
                onLongPress: () {
                  ref.read(totalTimeProvider.notifier).state -= const Duration(
                    minutes: 10,
                  );
                },
                child: IconUtils.kRemove,
              ),
              const SizedBox(width: 24),
              Text(
                formattedTotalTime,
                style: TextStyleUtils.kHeadline1,
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: () {
                  ref.read(totalTimeProvider.notifier).state += const Duration(
                    minutes: 1,
                  );
                },
                onLongPress: () {
                  ref.read(totalTimeProvider.notifier).state += const Duration(
                    minutes: 10,
                  );
                },
                child: IconUtils.kAdd,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Column>[
              Column(
                children: const <Text>[
                  Text(
                    'SET TIME',
                    style: TextStyleUtils.kHeadline3,
                  ),
                  Text(
                    'in minutes',
                    style: TextStyleUtils.kBodyText,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  ref.read(setTimeProvider.notifier).state -= const Duration(
                    minutes: 1,
                  );
                },
                onLongPress: () {
                  ref.read(setTimeProvider.notifier).state -= const Duration(
                    minutes: 5,
                  );
                },
                child: IconUtils.kRemove,
              ),
              const SizedBox(width: 24),
              Text(
                formattedSetTime,
                style: TextStyleUtils.kHeadline1,
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: () {
                  ref.read(setTimeProvider.notifier).state += const Duration(
                    minutes: 1,
                  );
                },
                onLongPress: () {
                  ref.read(setTimeProvider.notifier).state += const Duration(
                    minutes: 5,
                  );
                },
                child: IconUtils.kAdd,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Column>[
              Column(
                children: const <Text>[
                  Text(
                    'REST TIME',
                    style: TextStyleUtils.kHeadline3,
                  ),
                  Text(
                    'in seconds',
                    style: TextStyleUtils.kBodyText,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  ref.read(restTimeProvider.notifier).state -= const Duration(
                    seconds: 5,
                  );
                },
                onLongPress: () {
                  ref.read(restTimeProvider.notifier).state -= const Duration(
                    seconds: 20,
                  );
                },
                child: IconUtils.kRemove,
              ),
              const SizedBox(width: 24),
              Text(
                formattedRestTime,
                style: TextStyleUtils.kHeadline1,
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: () {
                  ref.read(restTimeProvider.notifier).state += const Duration(
                    seconds: 5,
                  );
                },
                onLongPress: () {
                  ref.read(restTimeProvider.notifier).state += const Duration(
                    seconds: 20,
                  );
                },
                child: IconUtils.kAdd,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
