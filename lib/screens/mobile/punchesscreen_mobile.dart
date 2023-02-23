import 'package:boksklapps/all_imports.dart';

class PunchesScreenMobile extends ConsumerStatefulWidget {
  const PunchesScreenMobile({super.key});

  @override
  ConsumerState<PunchesScreenMobile> createState() =>
      _PunchesScreenMobileState();
}

class _PunchesScreenMobileState extends ConsumerState<PunchesScreenMobile> {
  Color buttonColor = Colors.grey;

  Color changeButtonColor() {
    if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      setState(() {
        buttonColor = FlexColor.outerSpaceLightPrimary;
      });
    } else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      setState(() {
        buttonColor = FlexColor.outerSpaceDarkPrimary;
      });
    } else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      setState(() {
        buttonColor = FlexColor.moneyLightPrimary;
      });
    } else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      setState(() {
        buttonColor = FlexColor.moneyDarkPrimary;
      });
    } else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      setState(() {
        buttonColor = FlexColor.redWineLightPrimary;
      });
    } else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      setState(() {
        buttonColor = FlexColor.redWineDarkPrimary;
      });
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: StringUtils.kTimers,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            // Wrap the Column() in a SizedBox() to set the total height
            // at 85% of the screen height so that the SingleChildScrollView()
            // won't affect any of the widgets inside the Column()
            // and the keyboard can easily pop up without any issues
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Row>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const Text(
                            'JAB',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              changeButtonColor();
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                ref.read(punch1Provider.notifier).state =
                                    !ref.watch(punch1Provider);
                                if (ref.watch(punch1Provider) == true) {
                                  ref
                                      .read(punchListProvider.notifier)
                                      .state
                                      .add(1);
                                } else {
                                  ref
                                      .read(punchListProvider.notifier)
                                      .state
                                      .remove(1);
                                }
                              });
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {},
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
