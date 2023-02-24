import 'package:boksklapps/all_imports.dart';

class SetTimerFAB extends StatelessWidget {
  const SetTimerFAB({
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
              'assets/hourglass.gif',
            ),
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
