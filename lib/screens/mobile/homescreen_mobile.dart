import 'package:boksklapps/all_imports.dart';

/// HomeScreenMobile class
class HomeScreenMobile extends ConsumerWidget {
  /// HomeScreenMobile constructor
  const HomeScreenMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            StringUtils.kBoks + StringUtils.kKlapps,
          ),
          centerTitle: true,
        ),
        // Drawer hides if the screen width is less than 1000
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 48),
          child: Column(
            children: const <Widget>[
              GetShitDoneWidget(),
              Spacer(),
              TimerWidget(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
