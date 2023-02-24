import 'package:boksklapps/all_imports.dart';

class HomeScreenTablet extends ConsumerWidget {
  const HomeScreenTablet({
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
            child: Row(
              children: <Expanded>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      GetShitDoneWidget(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const StartBeastModeFAB(),
      ),
    );
  }
}
