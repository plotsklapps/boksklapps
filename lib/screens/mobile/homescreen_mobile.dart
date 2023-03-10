import 'package:boksklapps/all_imports.dart';

class HomeScreenMobile extends ConsumerWidget {
  const HomeScreenMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: StringUtils.kHome,
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
        floatingActionButton: const SetTimersFAB(),
      ),
    );
  }
}
