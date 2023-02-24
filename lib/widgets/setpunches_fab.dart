import 'package:boksklapps/all_imports.dart';

class SetPunchesFAB extends StatelessWidget {
  const SetPunchesFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await Navigator.pushNamed(
          context,
          '/punches_screen',
        );
      },
      label: Row(
        children: const <Widget>[
          Text(
            'Set Punches',
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
