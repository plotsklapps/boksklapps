import 'package:boksklapps/all_imports.dart';

/// TimerWidget class
class TimerWidget extends ConsumerWidget {
  /// TimerWidget constructor
  const TimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch timer states
    final totalTime = ref.watch(totalTimeProvider);
    final setTime = ref.watch(setTimeProvider);
    final restTime = ref.watch(restTimeProvider);

    // Format the timer states
    String format(Duration d) {
      return d.toString().split('.').first.padLeft(8, '0');
    }

    // Set formatted timer states in new variables
    final formattedTotalTime = format(totalTime);
    final formattedSetTime = format(setTime);
    final formattedRestTime = format(restTime);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        32,
        0,
        32,
        32,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              const SizedBox(width: 16),
              Text(
                formattedTotalTime,
                style: TextStyleUtils.kHeadline1,
              ),
              const SizedBox(width: 16),
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
            children: [
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              const SizedBox(width: 16),
              Text(
                formattedSetTime,
                style: TextStyleUtils.kHeadline1,
              ),
              const SizedBox(width: 16),
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
            children: [
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              const SizedBox(width: 16),
              Text(
                formattedRestTime,
                style: TextStyleUtils.kHeadline1,
              ),
              const SizedBox(width: 16),
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
