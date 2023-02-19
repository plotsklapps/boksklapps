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
        body: const Center(
          child: TimerWidget(),
        ),
      ),
    );
  }
}
