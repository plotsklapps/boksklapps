import 'package:boksklapps/all_imports.dart';

class TempoWidget extends ConsumerWidget {
  const TempoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String userTempoAsString = UserTempoRepository().getTempoLabel(
      ref,
      ref.watch(userTempoProvider),
    );

    return Column(
      children: <Widget>[
        const Text(
          'PUNCHING TEMPO',
          style: TextStyleUtils.kHeadline3,
        ),
        Slider(
          value: ref.watch(userTempoProvider),
          min: 1.0,
          max: 4.0,
          divisions: 3,
          onChanged: (double newTempo) async {
            await ref.read(userTempoProvider.notifier).updateUserTempo(
                  context,
                  ref,
                  newTempo,
                );
          },
        ),
        Text(
          userTempoAsString,
          style: TextStyleUtils.kHeadline3,
        ),
      ],
    );
  }
}
