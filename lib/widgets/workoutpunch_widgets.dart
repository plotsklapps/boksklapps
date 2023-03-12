import 'dart:math';

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
    AudioPlayer? audioPlayer;
    // Create a variable that holds the maxInt for the randomIndex
    final int maxInt = ref.watch(punchListProvider).length - 1;

    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible)
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      onEnd: () async {
        if (isVisible) {
          // If the AudioPlayer instance hasn't been created yet, create it
          audioPlayer ??= AudioPlayer();
          // Create a variable that holds the randomIndex we just set
          final int punchIndex = ref.watch(punchIndexProvider);
          // Create a String that holds the assetPath according to the
          // correct current punchIndex
          final String punchAudio =
              ref.watch(punchListProvider)[punchIndex].punchAudio;
          // Play the audio
          await audioPlayer!.play(AssetSource(punchAudio)).then((_) {
            audioPlayer!.onPlayerComplete.listen((_) {
              audioPlayer!.dispose();
            });
          });
        } else {
          // Create a randomIndex from 0 to maxInt
          final int randomIndex = Random().nextInt(maxInt + 1);
          // Write the randomIndex to the punchIndexProvider
          ref.read(punchIndexProvider.notifier).state = randomIndex;
        }
      },

      child: PunchImage(
        // punchIndex will have a new random value every time the
        // isVisible boolean from the AnimatedOpacity widget turns false
        punchIndex: ref.watch(punchIndexProvider),
      ),
    );
  }
}

class PunchImage extends ConsumerWidget {
  final int punchIndex; // the index of the punch you want to retrieve

  const PunchImage({super.key, required this.punchIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // First, retrieve the punchList (List<Punch>)
    final List<Punch> punchList = ref.watch(punchListProvider);

    // Then, retrieve the Strings for the specific punchIndex
    // given to this widget
    final String gloveImage = punchList[punchIndex].gloveImage;
    final String punchNumber = punchList[punchIndex].punchNumber;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image(
          image: AssetImage(
            gloveImage,
          ),
          height: 150.0,
          width: 150.0,
        ),
        Text(
          punchNumber,
          style: const TextStyle(
            fontSize: 96.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
