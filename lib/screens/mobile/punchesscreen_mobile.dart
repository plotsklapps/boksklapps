import 'package:boksklapps/all_imports.dart';

class PunchesScreenMobile extends ConsumerStatefulWidget {
  const PunchesScreenMobile({super.key});

  @override
  ConsumerState<PunchesScreenMobile> createState() =>
      _PunchesScreenMobileState();
}

class _PunchesScreenMobileState extends ConsumerState<PunchesScreenMobile> {
  bool nopeStartOver = false;

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
                SizedBox(
                  height: kMinInteractiveDimension,
                  child: Visibility(
                    visible: nopeStartOver,
                    child: ElevatedButton(
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
                        nopeStartOver = false;
                      },
                      child: const Text(
                        'NOPE. Start over.',
                      ),
                    ),
                  ),
                ),
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
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Text>[
                    Text(
                      'Punches to throw',
                      style: TextStyleUtils.kHeadline3,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: ref.watch(punchListProvider).length,
                    itemBuilder: (BuildContext context, int index) {
                      nopeStartOver = true;
                      final String punchString =
                          ref.watch(punchListProvider)[index];
                      return Row(
                        children: <Widget>[
                          Text(
                            punchString,
                            style: TextStyleUtils.kHeadline2,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
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
