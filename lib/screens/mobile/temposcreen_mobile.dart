import 'package:boksklapps/all_imports.dart';

class TempoScreenMobile extends StatelessWidget {
  const TempoScreenMobile({super.key});

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  TempoWidget(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: LayoutBuilder(
          // For smaller screens, the FAB is resized in a Flexible()
          // widget to fit the screen width
          builder: (BuildContext context, BoxConstraints constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const <Flexible>[
                  Flexible(
                    child: StartBeastModeFAB(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
