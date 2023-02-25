import 'package:boksklapps/all_imports.dart';

class StartBeastModeFAB extends StatelessWidget {
  const StartBeastModeFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Work in progress... Please come back later!',
            ),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ),
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
