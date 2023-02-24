import 'package:boksklapps/all_imports.dart';

class TempoScreenMobile extends ConsumerStatefulWidget {
  const TempoScreenMobile({super.key});

  @override
  ConsumerState<TempoScreenMobile> createState() => _PunchesScreenMobileState();
}

class _PunchesScreenMobileState extends ConsumerState<TempoScreenMobile> {
  double sliderValue = 5.0;

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
                  children: [
                    Text(
                      'TEMPO',
                      style: TextStyleUtils.kHeadline3,
                    ),
                    Text(
                      'Speed of punches',
                      style: TextStyleUtils.kBodyText,
                    ),
                    Slider(
                      value: sliderValue,
                      min: 1.0,
                      max: 10.0,
                      divisions: 9,
                      onChanged: (newValue) {
                        setState(() {
                          sliderValue = newValue;
                        });
                      },
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
