import 'package:boksklapps/all_imports.dart';

class StartBeastModeFAB extends ConsumerWidget {
  const StartBeastModeFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await Navigator.pushNamed(
          context,
          '/workout_screen',
        );
      },
      label: Row(
        children: const <Widget>[
          Text(
            'Start BeastMode',
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
