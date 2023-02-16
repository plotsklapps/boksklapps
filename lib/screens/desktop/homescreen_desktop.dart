import '../../all_imports.dart';

/// HomeScreenDesktop class
class HomeScreenDesktop extends StatelessWidget {
  /// HomeScreenDesktop constructor
  const HomeScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringUtils.kBoks + StringUtils.kKlapps,
        ),
        centerTitle: true,
      ),
      body: Row(
        children: <Widget>[
          // Drawer shows if the screen width is greater than 1000
          const DrawerWidget(),
          Expanded(
            child: Column(
              children: const <Widget>[
                GetShitDoneWidget(),
                TimerWidget(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconUtils.kForward,
      ),
    );
  }
}
