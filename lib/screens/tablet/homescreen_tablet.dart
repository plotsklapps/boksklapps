import 'package:boksklapps/all_imports.dart';

class HomeScreenTablet extends ConsumerWidget {
  const HomeScreenTablet({
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
            child: Row(
              children: <Expanded>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Row>[
                      Row(
                        children: const <Widget>[
                          GetShitDoneWidget(),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      GetShitDoneWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
