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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            GetShitDoneWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              '/timer_screen',
            );
          },
          label: Row(
            children: const <Widget>[
              Text(
                'Start Beast Mode',
                style: TextStyleUtils.kHeadline2,
              ),
              SizedBox(width: 10.0),
              IconUtils.kForward,
            ],
          ),
        ),
      ),
    );
  }
}
