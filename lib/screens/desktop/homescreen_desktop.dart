import 'package:boksklapps/all_imports.dart';

class HomeScreenDesktop extends StatelessWidget {
  const HomeScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: StringUtils.kHome,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          // Wrap the Row() in a SizedBox() to set the total height
          // at 85% of the screen height so that the SingleChildScrollView()
          // won't affect any of the widgets inside the Row()
          // and the keyboard can easily pop up without any issues
          height: MediaQuery.of(context).size.height * 0.85,
          child: Row(
            children: <Widget>[
              // Drawer shows if the screen width is greater than 1000
              const DrawerWidget(),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const StartBeastModeWidget(),
    );
  }
}
