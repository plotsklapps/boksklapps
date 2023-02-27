import 'dart:async';
import 'package:boksklapps/all_imports.dart';

class WorkoutScreenMobile extends ConsumerStatefulWidget {
  const WorkoutScreenMobile({super.key});

  @override
  WorkoutScreenMobileState createState() => WorkoutScreenMobileState();
}

class WorkoutScreenMobileState extends ConsumerState<WorkoutScreenMobile> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'WORKOUT',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            // Wrap the Column() in a SizedBox() to set the total height
            // at 85% of the screen height so that the SingleChildScrollView()
            // won't affect any of the widgets inside the Column()
            // and the keyboard can easily pop up without any issues
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const TotalTimerCountDownWidget(),
                  AnimatedOpacity(
                    opacity: _isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TotalTimerCountDownWidget extends ConsumerStatefulWidget {
  const TotalTimerCountDownWidget({super.key});

  @override
  TotalTimerCountDownWidgetState createState() =>
      TotalTimerCountDownWidgetState();
}

class TotalTimerCountDownWidgetState
    extends ConsumerState<TotalTimerCountDownWidget> {
  late Timer timer;
  late Duration remainingTime;

  @override
  void initState() {
    super.initState();
    remainingTime = ref.watch(totalTimerDurationProvider);
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (remainingTime.inSeconds > 0) {
          remainingTime = Duration(seconds: remainingTime.inSeconds - 1);
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${remainingTime.inMinutes.toString().padLeft(2, '0')}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyleUtils.kHeadline2,
    );
  }
}
