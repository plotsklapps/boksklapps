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
            'Start Beast Mode',
            style: TextStyleUtils.kHeadline2,
          ),
          SizedBox(width: 10.0),
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
