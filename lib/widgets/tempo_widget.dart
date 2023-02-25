import 'package:boksklapps/all_imports.dart';

class TempoWidget extends ConsumerWidget {
  const TempoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String userTempo = ref.watch(userTempoProvider);
    return Column(
      children: <Widget>[
        const Text(
          'PUNCHING TEMPO',
          style: TextStyleUtils.kHeadline3,
        ),
        Slider(
          value: userTempo == 'Easy'
              ? 1.0
              : userTempo == 'Moderate'
                  ? 2.0
                  : userTempo == 'Fast'
                      ? 3.0
                      : 4.0,
          min: 1.0,
          max: 4.0,
          divisions: 3,
          onChanged: (double newTempo) async {
            await ref.read(userTempoProvider.notifier).updateUserTempo(
                  context,
                  ref,
                  UserTempoRepository().convertTempoDoubleToString(newTempo),
                );
          },
        ),
        Text(
          userTempo,
          style: TextStyleUtils.kHeadline3,
        ),
      ],
    );
  }
}
