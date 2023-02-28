import 'package:boksklapps/all_imports.dart';

class WorkoutPunchWidget extends ConsumerWidget {
  const WorkoutPunchWidget({
    super.key,
    required this.isVisible,
  });

  final bool isVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String boxingGloveImage = ref.watch(boxingGloveProvider);
    final String boxingNumber = ref.watch(boxingNumberProvider);

    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible).
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(
        // TODO: Duration is set according to the userTempoProvider
        milliseconds: 500,
      ),
      onEnd: () {
        // Change the boxingGlove only if the widget is visible
        // Otherwise the animation 'stutters'
        if (isVisible == true) {
          ref.read(boxingGloveProvider.notifier).changeBoxingGlove(ref);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image(
            image: AssetImage(
              boxingGloveImage,
            ),
          ),
          Text(
            boxingNumber,
            style: const TextStyle(
              fontSize: 150.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
