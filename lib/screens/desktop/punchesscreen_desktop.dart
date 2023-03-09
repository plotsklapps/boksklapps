import 'package:boksklapps/all_imports.dart';

class PunchesScreenDesktop extends ConsumerStatefulWidget {
  const PunchesScreenDesktop({super.key});

  @override
  ConsumerState<PunchesScreenDesktop> createState() =>
      _PunchesScreenMobileState();
}

class _PunchesScreenMobileState extends ConsumerState<PunchesScreenDesktop> {
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
            child: Row(
              children: <Widget>[
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
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
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
                              // Toggle all the punches and add them to the
                              // punchListProvider
                              ref.read(punch1Provider.notifier).toggle(ref);
                              ref
                                  .read(punch1Provider.notifier)
                                  .addPunch1ToList(ref);
                              ref.read(punch2Provider.notifier).toggle(ref);
                              ref
                                  .read(punch2Provider.notifier)
                                  .addPunch2ToList(ref);
                              ref.read(punch3Provider.notifier).toggle(ref);
                              ref
                                  .read(punch3Provider.notifier)
                                  .addPunch3ToList(ref);
                              ref.read(punch4Provider.notifier).toggle(ref);
                              ref
                                  .read(punch4Provider.notifier)
                                  .addPunch4ToList(ref);
                              ref.read(punch5Provider.notifier).toggle(ref);
                              ref
                                  .read(punch5Provider.notifier)
                                  .addPunch5ToList(ref);
                              ref.read(punch6Provider.notifier).toggle(ref);
                              ref
                                  .read(punch6Provider.notifier)
                                  .addPunch6ToList(ref);
                              ref.read(punch1BProvider.notifier).toggle(ref);
                              ref
                                  .read(punch1BProvider.notifier)
                                  .addPunch1BToList(ref);
                              ref.read(punch2BProvider.notifier).toggle(ref);
                              ref
                                  .read(punch2BProvider.notifier)
                                  .addPunch2BToList(ref);
                              ref.read(punch3BProvider.notifier).toggle(ref);
                              ref
                                  .read(punch3BProvider.notifier)
                                  .addPunch3BToList(ref);
                              ref.read(punch4BProvider.notifier).toggle(ref);
                              ref
                                  .read(punch4BProvider.notifier)
                                  .addPunch4BToList(ref);
                            },
                            child: const Text(
                              'ADD ALL',
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          ElevatedButton(
                            onPressed: () {
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
                            },
                            child: const Text(
                              'RESET',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
