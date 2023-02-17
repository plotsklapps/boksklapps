import 'package:boksklapps/all_imports.dart';

/// TimerScreen class
class TimerScreen extends StatelessWidget {
  /// TimerScreen constructor
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;

    if (screenwidth < 700) {
      return const TimerScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      return const TimerScreenMobile();
    } else {
      return const TimerScreenMobile();
    }
  }
}
