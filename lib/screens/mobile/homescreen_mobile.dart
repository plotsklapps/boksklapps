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
        body: Column(
          children: <Widget>[
            const GetShitDoneWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Text>[
                    const Text(
                      'Welcome to BOKSklapps',
                      style: TextStyleUtils.kHeadline3,
                    ),
                    Text(
                      ref.watch(currentUserProvider)?.displayName ??
                          StringUtils.kNoAccount,
                      style: TextStyleUtils.kHeadline1,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const TimerWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
