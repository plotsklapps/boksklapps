import 'package:boksklapps/all_imports.dart';

class StartBeastModeWidget extends StatelessWidget {
  const StartBeastModeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await Navigator.pushNamed(
          context,
          '/timer_screen',
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
              'assets/boxer.gif',
            ),
          ),
        ],
      ),
    );
  }
}
