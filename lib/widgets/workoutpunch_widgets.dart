import 'dart:math';
import 'package:boksklapps/all_imports.dart';

class WorkoutPunchWidget extends ConsumerWidget {
  const WorkoutPunchWidget({
    super.key,
    required this.isVisible,
  });

  final bool isVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible)
      opacity: isVisible ? 1.0 : 0.0,
      // TODO: Make the duration dynamic relative to the users tempo
      duration: const Duration(milliseconds: 150),
      onEnd: () async {
        // When isVisible turns false, we set a new randomIndex from
        // the punchListProvider and give it to the PunchImage(punchIndex)
        // widget
        if (!isVisible) {
          final int maxInt = ref.watch(punchListProvider).length - 1;
          final int randomIndex = Random().nextInt(maxInt + 1);
          ref.read(punchIndexProvider.notifier).state = randomIndex;
          // Create an instance of AssetsAudioPlayer();
          final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
          // Create a variable that holds the randomIndex we just set
          final int punchIndex = ref.watch(punchIndexProvider);
          // Create a String that holds the assetPath according to the
          // correct punchIndex
          final String punchAudio =
              ref.watch(punchListProvider)[punchIndex].punchAudio;

          // Play sound!
          await audioPlayer.open(
            Audio(punchAudio),
          );
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
          height: 125.0,
          width: 125.0,
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
