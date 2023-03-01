import 'package:boksklapps/all_imports.dart';

class SetTimersFAB extends StatelessWidget {
  const SetTimersFAB({
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
            'Set Timers',
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
