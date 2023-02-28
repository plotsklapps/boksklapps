import 'package:boksklapps/all_imports.dart';

class WorkoutPunchWidget extends ConsumerWidget {
  WorkoutPunchWidget({
    super.key,
    required this.isVisible,
  });

  final bool isVisible;

  final StateProvider<String> boxingGloveProvider =
      StateProvider<String>((ref) {
    return 'assets/punch_cross.png';
  });

  final StateProvider<String> boxingNumberProvider =
      StateProvider<String>((ref) {
    return '2';
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String boxingGloveImage = ref.watch(boxingGloveProvider);
    final String boxingNumber = ref.watch(boxingNumberProvider);
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(
        milliseconds: 50,
      ),
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
