import 'package:boksklapps/all_imports.dart';

class PunchesScreenTablet extends ConsumerStatefulWidget {
  const PunchesScreenTablet({super.key});

  @override
  ConsumerState<PunchesScreenTablet> createState() =>
      _PunchesScreenMobileState();
}

class _PunchesScreenMobileState extends ConsumerState<PunchesScreenTablet> {
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
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Punch3ButtonWidget(
                            ref: ref,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Punch1ButtonWidget(
                            ref: ref,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Punch2ButtonWidget(
                            ref: ref,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Punch4ButtonWidget(
                            ref: ref,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Punch5ButtonWidget(
                            ref: ref,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Punch6ButtonWidget(
                            ref: ref,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Punch3BButtonWidget(
                            ref: ref,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Punch1BButtonWidget(
                            ref: ref,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Punch2BButtonWidget(
                            ref: ref,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Punch4BButtonWidget(
                            ref: ref,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
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
