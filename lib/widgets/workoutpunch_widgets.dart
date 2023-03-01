import 'package:audioplayers/audioplayers.dart';
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
        // TODO: Duration should be set according to the userTempoProvider
        milliseconds: 500,
      ),
      onEnd: () async {
        // Change the boxingGlove only if the widget is visible
        // Otherwise the animation 'stutters'
        if (isVisible == false) {
          ref.read(boxingGloveProvider.notifier).changeBoxingGlove(ref);
          ref.read(boxingNumberProvider.notifier).changeBoxingNumber(ref);
          await ref
              .read(boxingAudioProvider.notifier)
              .changeBoxingAudio(ref)
              .then((_) async {
            final String boxingAudio = ref.watch(boxingAudioProvider);
            await AudioPlayer().play(UrlSource(boxingAudio));
          });
        }
      },

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image(
            image: AssetImage(
              boxingGloveImage,
            ),
            height: 125.0,
            width: 125.0,
          ),
          Text(
            boxingNumber,
            style: const TextStyle(
              fontSize: 96.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
