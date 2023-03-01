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
          'REAR BODY HOOK',
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
                    (Punch punch) => punch.punchNumber == '4B',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch4BProvider).color,
          ),
          child: const Text(
            '4B',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          'BODY CROSS',
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
                    (Punch punch) => punch.punchNumber == '2B',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch2BProvider).color,
          ),
          child: const Text(
            '2B',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          'BODY JAB',
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
                    (Punch punch) => punch.punchNumber == '1B',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch1BProvider).color,
          ),
          child: const Text(
            '1B',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          'LEAD BODY HOOK',
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
                    (Punch punch) => punch.punchNumber == '3B',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch3BProvider).color,
          ),
          child: const Text(
            '3B',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          'REAR UPPERCUT',
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
                    (Punch punch) => punch.punchNumber == '6',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch6Provider).color,
          ),
          child: const Text(
            '6',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          'LEAD UPPERCUT',
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
                    (Punch punch) => punch.punchNumber == '5',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch5Provider).color,
          ),
          child: const Text(
            '5',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          'REAR HOOK',
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
                    (Punch punch) => punch.punchNumber == '4',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch4Provider).color,
          ),
          child: const Text(
            '4',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          'CROSS',
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
                    (Punch punch) => punch.punchNumber == '2',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch2Provider).color,
          ),
          child: const Text(
            '2',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          'JAB',
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
                    (Punch punch) => punch.punchNumber == '1',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch1Provider).color,
          ),
          child: const Text(
            '1',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
          'LEAD HOOK',
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
                    (Punch punch) => punch.punchNumber == '3',
                  );
            }
          },
          //If button is selected, change color according
          //to the current chosen themeMode and themeColor
          style: ElevatedButton.styleFrom(
            backgroundColor: ref.watch(punch3Provider).color,
          ),
          child: const Text(
            '3',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
