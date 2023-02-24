import 'package:boksklapps/all_imports.dart';

class TempoScreenMobile extends ConsumerStatefulWidget {
  const TempoScreenMobile({super.key});

  @override
  ConsumerState<TempoScreenMobile> createState() => _PunchesScreenMobileState();
}

class _PunchesScreenMobileState extends ConsumerState<TempoScreenMobile> {
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
                Column(
                  children: <Widget>[
                    const Text(
                      'PUNCHING TEMPO',
                      style: TextStyleUtils.kHeadline3,
                    ),
                    Slider(
                      value: ref.watch(tempoDoubleProvider),
                      min: 1.0,
                      max: 4.0,
                      divisions: 3,
                      onChanged: (double newValue) async {
                        await ref
                            .read(tempoDoubleProvider.notifier)
                            .setTempoDouble(
                              newValue,
                              ref,
                            );
                      },
                    ),
                    Text(
                      ref.watch(tempoStringProvider),
                      style: TextStyleUtils.kHeadline3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const StartBeastModeFAB(),
      ),
    );
  }
}
