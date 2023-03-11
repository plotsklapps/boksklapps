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
                        ButtonStateNotifier().addAllToPunchList(ref);
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
                        ButtonStateNotifier().removeAllFromPunchList(ref);
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
