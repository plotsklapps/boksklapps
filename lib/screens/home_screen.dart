import 'package:boksklapps/all_imports.dart';

/// HomeScreen class
class HomeScreen extends StatelessWidget {
  /// HomeScreen constructor
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1000) {
      return const HomeScreenMobile();
    } else {
      return const HomeScreenDesktop();
    }
  }
}

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
      body: const Center(
        child: Text(
          'Welcome to BOKSKLAPPS',
          style: TextStyleUtils.kBodyText,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconUtils.kForward,
      ),
    );
  }
}

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
        children: const [
          // Drawer shows if the screen width is greater than 1000
          DrawerWidget(),
          Expanded(
            child: Center(
              child: Text(
                'Welcome to BOKSKLAPPS',
                style: TextStyleUtils.kBodyText,
              ),
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
