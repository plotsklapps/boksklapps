import 'package:boksklapps/all_imports.dart';

/// PunchesScreen class
class PunchesScreen extends StatelessWidget {
  /// PunchesScreen constructor
  const PunchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;

    if (screenwidth < 700) {
      return const PunchesScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      //TODO: Add a tablet version
      return const PunchesScreenMobile();
    } else {
      //TODO: Add a desktop version
      return const PunchesScreenMobile();
    }
  }
}
