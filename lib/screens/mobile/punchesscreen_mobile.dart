import 'package:boksklapps/all_imports.dart';

class PunchesScreenMobile extends ConsumerStatefulWidget {
  const PunchesScreenMobile({super.key});

  @override
  ConsumerState<PunchesScreenMobile> createState() =>
      _PunchesScreenMobileState();
}

class _PunchesScreenMobileState extends ConsumerState<PunchesScreenMobile> {
  bool buttonState = false;
  Color buttonColor = Colors.grey;

  Color changeButtonColor() {
    if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      buttonColor =
          buttonState ? FlexColor.outerSpaceLightPrimaryContainer : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.outerSpace) {
      buttonColor = buttonState ? FlexColor.outerSpaceDarkPrimary : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      buttonColor =
          buttonState ? FlexColor.moneyLightPrimaryContainer : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.money) {
      buttonColor = buttonState ? FlexColor.moneyDarkPrimary : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.light &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      buttonColor =
          buttonState ? FlexColor.redWineLightPrimaryContainer : Colors.grey;
    } else if (ref.watch(themeModeProvider) == ThemeMode.dark &&
        ref.watch(themeColorProvider) == FlexScheme.redWine) {
      buttonColor = buttonState ? FlexColor.redWineDarkPrimary : Colors.grey;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: StringUtils.kPunches,
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
                            'LEAD HOOK',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
                                ref.read(punch3Provider.notifier).state =
                                    !ref.watch(punch3Provider);
                                if (ref.watch(punch3Provider) == true) {
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
                              changeButtonColor();
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '3',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'JAB',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
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
                              changeButtonColor();
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
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'CROSS',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
                                ref.read(punch2Provider.notifier).state =
                                    !ref.watch(punch2Provider);
                                if (ref.watch(punch2Provider) == true) {
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
                              changeButtonColor();
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '2',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'REAR HOOK',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
                                ref.read(punch4Provider.notifier).state =
                                    !ref.watch(punch4Provider);
                                if (ref.watch(punch4Provider) == true) {
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
                              changeButtonColor();
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '4',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          const Text(
                            'LEAD UPPERCUT',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
                                ref.read(punch5Provider.notifier).state =
                                    !ref.watch(punch5Provider);
                                if (ref.watch(punch5Provider) == true) {
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
                              changeButtonColor();
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '5',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'REAR UPPERCUT',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
                                ref.read(punch6Provider.notifier).state =
                                    !ref.watch(punch6Provider);
                                if (ref.watch(punch6Provider) == true) {
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
                              changeButtonColor();
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '6',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          const Text(
                            'REAR BODY HOOK',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
                                ref.read(punch3BProvider.notifier).state =
                                    !ref.watch(punch3BProvider);
                                if (ref.watch(punch3BProvider) == true) {
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
                              changeButtonColor();
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '3B',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'BODY JAB',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
                                ref.read(punch1BProvider.notifier).state =
                                    !ref.watch(punch1BProvider);
                                if (ref.watch(punch1BProvider) == true) {
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
                              changeButtonColor();
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '1B',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'BODY CROSS',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
                                ref.read(punch2BProvider.notifier).state =
                                    !ref.watch(punch2BProvider);
                                if (ref.watch(punch2BProvider) == true) {
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
                              changeButtonColor();
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '2B',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'REAR BODY HOOK',
                            style: TextStyleUtils.kBodyText,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Every punchProvider has a number, corresponding to
                                //original boxing methods (Jab = 1, Cross = 2, etc.).
                                //If user selects a number, the punchProvider will set
                                //to 'true' and if it's 'true', it should add the
                                //corresponding punch number to the punchListProvider
                                //and vice versa
                                buttonState = !buttonState;
                                ref.read(punch4BProvider.notifier).state =
                                    !ref.watch(punch4BProvider);
                                if (ref.watch(punch4BProvider) == true) {
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
                              changeButtonColor();
                            },
                            //If button is selected, change color
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: const Text(
                              '4B',
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
