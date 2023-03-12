import 'package:audioplayers/audioplayers.dart';
import 'package:boksklapps/all_imports.dart';

class SoundSwitch extends ConsumerWidget {
  const SoundSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<bool> isSelected = <bool>[
      ref.watch(userSoundProvider) == 0,
      ref.watch(userSoundProvider) == 1,
    ];

    return ToggleButtons(
      // The state of each button is controlled by isSelected,
      // which is a list of bools that determine if a button
      // is in an active, disabled, or selected state.
      // They are both correlated by their index in the list.
      // The length of isSelected has to match
      // the length of the children list.
      isSelected: isSelected,
      onPressed: (int newIndex) async {
        if (newIndex == 0) {
          // Set the state of userSoundProvider to 0
          // and set the String of userSoundStringProvider to 'Ellie'
          await ref.read(userSoundProvider.notifier).updateUserSound(
                context,
                ref,
                0,
              );
          await ref.read(userSoundStringProvider.notifier).setUserSoundString(
                'Elli',
              );
          final AudioPlayer audioPlayer = AudioPlayer();
          // Play sound and dispose after completion
          await audioPlayer.play(AssetSource(SoundUtils.kNameElli)).then((_) {
            audioPlayer.onPlayerComplete.listen((_) {
              audioPlayer.dispose();
            });
          });
        } else if (newIndex == 1) {
          // Set the state of userSoundProvider to 1
          // and set the String of userSoundStringProvider to 'Arnold'
          await ref.read(userSoundProvider.notifier).updateUserSound(
                context,
                ref,
                1,
              );
          await ref.read(userSoundStringProvider.notifier).setUserSoundString(
                'Arnold',
              );
          final AudioPlayer audioPlayer = AudioPlayer();
          // Play sound and dispose after completion
          await audioPlayer.play(AssetSource(SoundUtils.kNameArnold)).then(
            (_) {
              audioPlayer.onPlayerComplete.listen((_) {
                audioPlayer.dispose();
              });
            },
          );
        }
      },
      children: const <Icon>[
        IconUtils.kWoman,
        IconUtils.kMan,
      ],
    );
  }
}
