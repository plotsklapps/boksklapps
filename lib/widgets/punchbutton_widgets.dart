import 'package:boksklapps/all_imports.dart';

class Punch4BButtonWidget extends StatelessWidget {
  const Punch4BButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kRearBodyHook,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            // Every punchProvider has a number, corresponding to
            // original boxing methods (Jab = 1, Cross = 2, etc.).
            // If user selects a number, the punchProvider's
            // ButtonStateNotifier will set it the button
            // to 'true' and if it's 'true', it should add the
            // corresponding Punch to the punchListProvider
            // and vice versa AND change the color of the button according
            // to the current chosen themeMode and themeColor
            ref.read(punch4BProvider.notifier).toggle(ref);
            if (ref.watch(punch4BProvider).isOn == true) {
              ref.read(punch4BProvider.notifier).addPunch4BToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k4B,
                  );
            }
          },
          // If button is selected, change color according
          // to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch4BProvider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kRearBodyHookPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k4B,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Punch2BButtonWidget extends StatelessWidget {
  const Punch2BButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kBodyCross,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            //Every punchProvider has a number, corresponding to
            //original boxing methods (Jab = 1, Cross = 2, etc.).
            //If user selects a number, the punchProvider will set
            //to 'true' and if it's 'true', it should add the
            //corresponding punch number to the punchListProvider
            //and vice versa AND change the color of the button according
            //to the current chosen themeMode and themeColor
            ref.read(punch2BProvider.notifier).toggle(ref);
            if (ref.watch(punch2BProvider).isOn == true) {
              ref.read(punch2BProvider.notifier).addPunch2BToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k2B,
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch2BProvider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kBodyCrossPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k2B,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Punch1BButtonWidget extends StatelessWidget {
  const Punch1BButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kBodyJab,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            //Every punchProvider has a number, corresponding to
            //original boxing methods (Jab = 1, Cross = 2, etc.).
            //If user selects a number, the punchProvider will set
            //to 'true' and if it's 'true', it should add the
            //corresponding punch number to the punchListProvider
            //and vice versa AND change the color of the button according
            //to the current chosen themeMode and themeColor
            ref.read(punch1BProvider.notifier).toggle(ref);
            if (ref.watch(punch1BProvider).isOn == true) {
              ref.read(punch1BProvider.notifier).addPunch1BToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k1B,
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch1BProvider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kBodyJabPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k1B,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Punch3BButtonWidget extends StatelessWidget {
  const Punch3BButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kLeadBodyHook,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            //Every punchProvider has a number, corresponding to
            //original boxing methods (Jab = 1, Cross = 2, etc.).
            //If user selects a number, the punchProvider will set
            //to 'true' and if it's 'true', it should add the
            //corresponding punch number to the punchListProvider
            //and vice versa AND change the color of the button according
            //to the current chosen themeMode and themeColor
            ref.read(punch3BProvider.notifier).toggle(ref);
            if (ref.watch(punch3BProvider).isOn == true) {
              ref.read(punch3BProvider.notifier).addPunch3BToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k3B,
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch3BProvider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kLeadBodyHookPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k3B,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Punch6ButtonWidget extends StatelessWidget {
  const Punch6ButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kRearUppercut,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            //Every punchProvider has a number, corresponding to
            //original boxing methods (Jab = 1, Cross = 2, etc.).
            //If user selects a number, the punchProvider will set
            //to 'true' and if it's 'true', it should add the
            //corresponding punch number to the punchListProvider
            //and vice versa AND change the color of the button according
            //to the current chosen themeMode and themeColor
            ref.read(punch6Provider.notifier).toggle(ref);
            if (ref.watch(punch6Provider).isOn == true) {
              ref.read(punch6Provider.notifier).addPunch6ToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k6,
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch6Provider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kRearUppercutPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k6,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Punch5ButtonWidget extends StatelessWidget {
  const Punch5ButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kLeadUppercut,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            //Every punchProvider has a number, corresponding to
            //original boxing methods (Jab = 1, Cross = 2, etc.).
            //If user selects a number, the punchProvider will set
            //to 'true' and if it's 'true', it should add the
            //corresponding punch number to the punchListProvider
            //and vice versa AND change the color of the button according
            //to the current chosen themeMode and themeColor
            ref.read(punch5Provider.notifier).toggle(ref);
            if (ref.watch(punch5Provider).isOn == true) {
              ref.read(punch5Provider.notifier).addPunch5ToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k5,
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch5Provider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kLeadUppercutPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k5,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Punch4ButtonWidget extends StatelessWidget {
  const Punch4ButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kRearHook,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            //Every punchProvider has a number, corresponding to
            //original boxing methods (Jab = 1, Cross = 2, etc.).
            //If user selects a number, the punchProvider will set
            //to 'true' and if it's 'true', it should add the
            //corresponding punch number to the punchListProvider
            //and vice versa AND change the color of the button according
            //to the current chosen themeMode and themeColor
            ref.read(punch4Provider.notifier).toggle(ref);
            if (ref.watch(punch4Provider).isOn == true) {
              ref.read(punch4Provider.notifier).addPunch4ToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k4,
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch4Provider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kRearHookPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k4,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Punch2ButtonWidget extends StatelessWidget {
  const Punch2ButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kCross,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            //Every punchProvider has a number, corresponding to
            //original boxing methods (Jab = 1, Cross = 2, etc.).
            //If user selects a number, the punchProvider will set
            //to 'true' and if it's 'true', it should add the
            //corresponding punch number to the punchListProvider
            //and vice versa AND change the color of the button according
            //to the current chosen themeMode and themeColor
            ref.read(punch2Provider.notifier).toggle(ref);
            if (ref.watch(punch2Provider).isOn == true) {
              ref.read(punch2Provider.notifier).addPunch2ToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k2,
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch2Provider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kCrossPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k2,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Punch1ButtonWidget extends StatelessWidget {
  const Punch1ButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kJab,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            //Every punchProvider has a number, corresponding to
            //original boxing methods (Jab = 1, Cross = 2, etc.).
            //If user selects a number, the punchProvider will set
            //to 'true' and if it's 'true', it should add the
            //corresponding punch number to the punchListProvider
            //and vice versa AND change the color of the button according
            //to the current chosen themeMode and themeColor
            ref.read(punch1Provider.notifier).toggle(ref);
            if (ref.watch(punch1Provider).isOn == true) {
              ref.read(punch1Provider.notifier).addPunch1ToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k1,
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch1Provider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kJabPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k1,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Punch3ButtonWidget extends StatelessWidget {
  const Punch3ButtonWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          StringUtils.kLeadHook,
          style: TextStyleUtils.kBodyText,
        ),
        ElevatedButton(
          onPressed: () {
            //Every punchProvider has a number, corresponding to
            //original boxing methods (Jab = 1, Cross = 2, etc.).
            //If user selects a number, the punchProvider will set
            //to 'true' and if it's 'true', it should add the
            //corresponding punch number to the punchListProvider
            //and vice versa AND change the color of the button according
            //to the current chosen themeMode and themeColor
            ref.read(punch3Provider.notifier).toggle(ref);
            if (ref.watch(punch3Provider).isOn == true) {
              ref.read(punch3Provider.notifier).addPunch3ToList(ref);
            } else {
              ref.read(punchListProvider.notifier).state.removeWhere(
                    (Punch punch) => punch.punchNumber == StringUtils.k3,
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch3Provider).color,
            maximumSize: const Size(
              SizeUtils.kPunchButtonHeight,
              SizeUtils.kPunchButtonWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Flexible(
                child: Image(
                  image: AssetImage(
                    StringUtils.kLeadHookPath,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Text(
                  StringUtils.k3,
                  style: TextStyleUtils.kHeadline3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
