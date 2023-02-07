import 'package:boksklapps/all_imports.dart';

/// HomeScreenMobile class
class HomeScreenMobile extends StatelessWidget {
  /// HomeScreenMobile constructor
  const HomeScreenMobile({
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
      // Drawer hides if the screen width is less than 1000
      drawer: const DrawerWidget(),
      body: Column(
        children: const [
          GetShitDoneWidget(),
          TimerWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconUtils.kForward,
      ),
    );
  }
}
