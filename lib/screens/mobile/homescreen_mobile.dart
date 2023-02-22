import 'package:boksklapps/all_imports.dart';

class HomeScreenMobile extends ConsumerWidget {
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
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                GetShitDoneWidget(),
              ],
            ),
          ),
        ),
        floatingActionButton: const StartBeastModeWidget(),
      ),
    );
  }
}
