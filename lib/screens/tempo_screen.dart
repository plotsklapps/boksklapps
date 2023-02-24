import 'package:boksklapps/all_imports.dart';

/// TempoScreen class
class TempoScreen extends StatelessWidget {
  /// TempoScreen constructor
  const TempoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;

    if (screenwidth < 700) {
      return const TempoScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      //TODO: Create tablet version
      return const TempoScreenMobile();
    } else {
      //TODO: Create desktop version
      return const TempoScreenMobile();
    }
  }
}
