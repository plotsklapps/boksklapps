import 'package:boksklapps/all_imports.dart';

class TempoScreenTablet extends StatelessWidget {
  const TempoScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: StringUtils.kTempo,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            // Wrap the Column() in a SizedBox() to set the total height
            // at 85% of the screen height so that the SingleChildScrollView()
            // won't affect any of the widgets inside the Column()
            // and the keyboard can easily pop up without any issues
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        TempoWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: const StartBeastModeFAB(),
      ),
    );
  }
}
