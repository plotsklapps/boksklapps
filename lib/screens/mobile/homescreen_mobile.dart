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
        drawer: const DrawerWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            GetShitDoneWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              '\timer_screen',
            );
          },
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
