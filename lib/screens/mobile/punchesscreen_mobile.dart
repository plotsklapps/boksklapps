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
              children: <Row>[
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
