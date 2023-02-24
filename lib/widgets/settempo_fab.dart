import 'package:boksklapps/all_imports.dart';

class SetTempoFAB extends StatelessWidget {
  const SetTempoFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await Navigator.pushNamed(
          context,
          '/tempo_screen',
        );
      },
      label: Row(
        children: const <Widget>[
          Text(
            'Set Tempo',
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
