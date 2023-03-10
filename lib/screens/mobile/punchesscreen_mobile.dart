import 'package:boksklapps/all_imports.dart';

class PunchesScreenMobile extends ConsumerStatefulWidget {
  const PunchesScreenMobile({super.key});

  @override
  ConsumerState<PunchesScreenMobile> createState() =>
      _PunchesScreenMobileState();
}

class _PunchesScreenMobileState extends ConsumerState<PunchesScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: StringUtils.kPunches,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    // Use Flexible widgets to make the buttons fit
                    // on smaller mobile screens
                    Punch3ButtonWidget(),
                    SizedBox(
                      width: 10.0,
                    ),
                    Punch1ButtonWidget(),
                    SizedBox(
                      width: 10.0,
                    ),
                    Punch2ButtonWidget(),
                    SizedBox(
                      width: 10.0,
                    ),
                    Punch4ButtonWidget(),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Punch5ButtonWidget(),
                    SizedBox(
                      width: 10.0,
                    ),
                    Punch6ButtonWidget(),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Punch3BButtonWidget(),
                    SizedBox(
                      width: 10.0,
                    ),
                    Punch1BButtonWidget(),
                    SizedBox(
                      width: 10.0,
                    ),
                    Punch2BButtonWidget(),
                    SizedBox(
                      width: 10.0,
                    ),
                    Punch4BButtonWidget(),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        addAllToPunchList(ref);
                      },
                      child: Row(
                        children: const <Widget>[
                          IconUtils.kAdd,
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'ADD ALL',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ElevatedButton(
                      onPressed: () {
                        removeAllFromPunchList(ref);
                      },
                      child: Row(
                        children: const <Widget>[
                          Text(
                            'RESET',
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          IconUtils.kRemove,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const SetTempoFAB(),
      ),
    );
  }
}

void addAllToPunchList(WidgetRef ref) {
  // Toggle all the punches and add them to the
  // punchListProvider
  ref.read(punch1Provider.notifier).toggle(ref);
  ref.read(punch1Provider.notifier).addPunch1ToList(ref);
  ref.read(punch2Provider.notifier).toggle(ref);
  ref.read(punch2Provider.notifier).addPunch2ToList(ref);
  ref.read(punch3Provider.notifier).toggle(ref);
  ref.read(punch3Provider.notifier).addPunch3ToList(ref);
  ref.read(punch4Provider.notifier).toggle(ref);
  ref.read(punch4Provider.notifier).addPunch4ToList(ref);
  ref.read(punch5Provider.notifier).toggle(ref);
  ref.read(punch5Provider.notifier).addPunch5ToList(ref);
  ref.read(punch6Provider.notifier).toggle(ref);
  ref.read(punch6Provider.notifier).addPunch6ToList(ref);
  ref.read(punch1BProvider.notifier).toggle(ref);
  ref.read(punch1BProvider.notifier).addPunch1BToList(ref);
  ref.read(punch2BProvider.notifier).toggle(ref);
  ref.read(punch2BProvider.notifier).addPunch2BToList(ref);
  ref.read(punch3BProvider.notifier).toggle(ref);
  ref.read(punch3BProvider.notifier).addPunch3BToList(ref);
  ref.read(punch4BProvider.notifier).toggle(ref);
  ref.read(punch4BProvider.notifier).addPunch4BToList(ref);
}

void removeAllFromPunchList(WidgetRef ref) {
  // Toggle all the punches and remove them from the
  // punchListProvider
  ref.invalidate(punchListProvider);
  ref.invalidate(punch1Provider);
  ref.invalidate(punch2Provider);
  ref.invalidate(punch3Provider);
  ref.invalidate(punch4Provider);
  ref.invalidate(punch5Provider);
  ref.invalidate(punch6Provider);
  ref.invalidate(punch1BProvider);
  ref.invalidate(punch2BProvider);
  ref.invalidate(punch3BProvider);
  ref.invalidate(punch4BProvider);
}
