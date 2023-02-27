import 'package:boksklapps/all_imports.dart';

/// WorkoutScreen class
class WorkoutScreen extends StatelessWidget {
  /// WorkoutScreen constructor
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    if (screenwidth < 700) {
      return const WorkoutScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      // TODO: Create tablet version
      return const WorkoutScreenMobile();
    } else {
      // TODO: Create desktop version
      return const WorkoutScreenMobile();
    }
  }
}
