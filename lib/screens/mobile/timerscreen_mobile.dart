import 'package:boksklapps/all_imports.dart';

class TimerScreenMobile extends StatelessWidget {
  const TimerScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            StringUtils.kBoks + StringUtils.kKlapps,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: const <Widget>[
                TotalTimerPicker(),
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

class TotalTimerPicker extends StatefulWidget {
  const TotalTimerPicker({super.key});

  @override
  TotalTimerPickerState createState() => TotalTimerPickerState();
}

class TotalTimerPickerState extends State<TotalTimerPicker> {
  double totalTimer = 30.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Total Time',
          style: TextStyleUtils.kHeadline3,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          '${totalTimer.toInt()} minutes',
          style: TextStyleUtils.kHeadline2,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Slider(
          value: totalTimer,
          min: 10.0,
          max: 90.0,
          divisions: 8,
          onChanged: (double newTotalTime) {
            setState(() {
              totalTimer = newTotalTime;
            });
          },
        ),
      ],
    );
  }
}
