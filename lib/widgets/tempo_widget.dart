import 'package:boksklapps/all_imports.dart';

class TempoWidget extends ConsumerWidget {
  const TempoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String tempoString = ref.watch(userTempoProvider);
    final double tempoDouble = UserTempoRepository().convertTempoStringToDouble(
      tempoString,
    );
    return Column(
      children: <Widget>[
        const Text(
          'PUNCHING TEMPO',
          style: TextStyleUtils.kHeadline3,
        ),
        Slider(
          value: tempoDouble,
          min: 1.0,
          max: 4.0,
          divisions: 3,
          onChanged: (double newTempo) async {
            await ref.read(userTempoProvider.notifier).updateUserTempo(
                  context,
                  ref,
                  newTempo.toStringAsFixed(1),
                );
          },
        ),
        Text(
          ref.watch(userTempoProvider),
          style: TextStyleUtils.kHeadline3,
        ),
      ],
    );
  }
}
