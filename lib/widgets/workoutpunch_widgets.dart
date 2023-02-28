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
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(
        milliseconds: 100,
      ),
      onEnd: () {
        if (isVisible) {
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
