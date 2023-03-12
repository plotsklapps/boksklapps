import 'package:boksklapps/all_imports.dart';

final StateNotifierProvider<VoicesNotifier, Set<Voices>> voicesProvider =
    StateNotifierProvider<VoicesNotifier, Set<Voices>>((_) {
  return VoicesNotifier();
});

class VoicesNotifier extends StateNotifier<Set<Voices>> {
  VoicesNotifier() : super(<Voices>{Voices.elli});

  void changeVoiceValue(Voices value) => state = <Voices>{value};
}

enum Voices { elli, arnold }

class VoiceSwitch extends ConsumerStatefulWidget {
  const VoiceSwitch({super.key});

  @override
  ConsumerState<VoiceSwitch> createState() => VoiceSwitchState();
}

class VoiceSwitchState extends ConsumerState<VoiceSwitch> {
  @override
  Widget build(BuildContext context) {
    final Voices voicesView = ref.watch(voicesProvider).first;
    return SegmentedButton<Voices>(
      segments: const <ButtonSegment<Voices>>[
        ButtonSegment<Voices>(value: Voices.elli, icon: IconUtils.kWoman),
        ButtonSegment<Voices>(value: Voices.arnold, icon: IconUtils.kMan),
      ],
      selected: <Voices>{voicesView},
      onSelectionChanged: (Set<Voices> newSelection) async {
        ref.read(voicesProvider.notifier).changeVoiceValue(newSelection.first);
        final Voices voice = ref.watch(voicesProvider).first;
        if (voice == Voices.elli) {
          // Set the state of userSoundProvider to 0
          await ref.read(userSoundProvider.notifier).updateUserSound(
                context,
                ref,
                0,
              );
          // Set the String of userSoundStringProvider to 'Elli'
          await ref.read(userSoundStringProvider.notifier).setUserSoundString(
                'Elli',
              );
          await playElliSound();
        } else if (voice == Voices.arnold) {
          // Set the state of userSoundProvider to 1
          await ref.read(userSoundProvider.notifier).updateUserSound(
                context,
                ref,
                1,
              );
          // Set the String of userSoundStringProvider to 'Arnold'
          await ref.read(userSoundStringProvider.notifier).setUserSoundString(
                'Arnold',
              );
          await playArnoldSound();
        }
      },
    );
  }

  Future<void> playElliSound() async {
    final AudioPlayer audioPlayerElli = AudioPlayer();
    // Play sound
    await audioPlayerElli.setAsset(SoundUtils.kNameElli).then((_) {
      audioPlayerElli.play();
    });
    await audioPlayerElli.playerStateStream
        .where(
          (PlayerState state) =>
              state.processingState == ProcessingState.completed,
        )
        .first
        .then((_) => audioPlayerElli.dispose());
  }

  Future<void> playArnoldSound() async {
    final AudioPlayer audioPlayerArnold = AudioPlayer();
    // Play sound
    await audioPlayerArnold.setAsset(SoundUtils.kNameArnold).then((_) {
      audioPlayerArnold.play();
    });
    await audioPlayerArnold.playerStateStream
        .where(
          (PlayerState state) =>
              state.processingState == ProcessingState.completed,
        )
        .first
        .then((_) => audioPlayerArnold.dispose());
  }
}
