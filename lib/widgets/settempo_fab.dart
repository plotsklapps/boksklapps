import 'package:boksklapps/all_imports.dart';

class SetTempoFAB extends ConsumerWidget {
  const SetTempoFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () async {
        // No point in going forward if no punches are provided
        final int maxInt = ref.read(punchListProvider).length;
        if (maxInt == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Add some punches first...',
              ),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
        } else {
          // Let's go beastmode!
          await Navigator.pushNamed(
            context,
            '/tempo_screen',
          );
        }
      },
      label: Row(
        children: const <Widget>[
          Text(
            'Set Tempo',
            style: TextStyleUtils.kHeadline3,
          ),
          Image(
            image: AssetImage(
              'assets/GIF/boxer.gif',
            ),
          ),
        ],
      ),
    );
  }
}
