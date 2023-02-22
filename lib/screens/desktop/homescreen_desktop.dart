import 'package:boksklapps/all_imports.dart';

class HomeScreenDesktop extends StatelessWidget {
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Row(
            children: <Widget>[
              // Drawer shows if the screen width is greater than 1000
              const DrawerWidget(),
              Expanded(
                child: Column(
                  children: const <Widget>[
                    GetShitDoneWidget(),
                    TimerWidget(),
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
    );
  }
}
