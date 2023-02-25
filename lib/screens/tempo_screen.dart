import 'package:boksklapps/all_imports.dart';
import 'package:boksklapps/screens/tablet/temposcreen_tablet.dart';

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
      return const TempoScreenTablet();
    } else {
      return const TempoScreenDesktop();
    }
  }
}
