import 'package:boksklapps/all_imports.dart';

class Punch1ButtonWidget extends ConsumerWidget {
  const Punch1ButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch1Provider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch1Provider.notifier).toggle(ref);
          if (ref.watch(punch1Provider).isOn == true) {
            await ref.watch(audioProvider).playJabAudio();
            ref.read(punch1Provider.notifier).addPunch1ToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k1,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kJabPath,
          ),
        ),
      ),
    );
  }
}

class Punch2ButtonWidget extends ConsumerWidget {
  const Punch2ButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch2Provider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch2Provider.notifier).toggle(ref);
          if (ref.watch(punch2Provider).isOn == true) {
            await ref.watch(audioProvider).playCrossAudio();
            ref.read(punch2Provider.notifier).addPunch2ToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k2,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kCrossPath,
          ),
        ),
      ),
    );
  }
}

class Punch3ButtonWidget extends ConsumerWidget {
  const Punch3ButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch3Provider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch3Provider.notifier).toggle(ref);
          if (ref.watch(punch3Provider).isOn == true) {
            await ref.watch(audioProvider).playLeadHookAudio();
            ref.read(punch3Provider.notifier).addPunch3ToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k3,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kLeadHookPath,
          ),
        ),
      ),
    );
  }
}

class Punch4ButtonWidget extends ConsumerWidget {
  const Punch4ButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch4Provider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch4Provider.notifier).toggle(ref);
          if (ref.watch(punch4Provider).isOn == true) {
            await ref.watch(audioProvider).playRearHookAudio();
            ref.read(punch4Provider.notifier).addPunch4ToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k4,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kRearHookPath,
          ),
        ),
      ),
    );
  }
}

class Punch5ButtonWidget extends ConsumerWidget {
  const Punch5ButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch5Provider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch5Provider.notifier).toggle(ref);
          if (ref.watch(punch5Provider).isOn == true) {
            await ref.watch(audioProvider).playLeadUppercutAudio();
            ref.read(punch5Provider.notifier).addPunch5ToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k5,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kLeadUppercutPath,
          ),
        ),
      ),
    );
  }
}

class Punch6ButtonWidget extends ConsumerWidget {
  const Punch6ButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch6Provider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch6Provider.notifier).toggle(ref);
          if (ref.watch(punch6Provider).isOn == true) {
            await ref.watch(audioProvider).playRearUppercutAudio();
            ref.read(punch6Provider.notifier).addPunch6ToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k6,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kRearUppercutPath,
          ),
        ),
      ),
    );
  }
}

class Punch1BButtonWidget extends ConsumerWidget {
  const Punch1BButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch1BProvider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch1BProvider.notifier).toggle(ref);
          if (ref.watch(punch1BProvider).isOn == true) {
            await ref.watch(audioProvider).playBodyJabAudio();
            ref.read(punch1BProvider.notifier).addPunch1BToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k1B,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kBodyJabPath,
          ),
        ),
      ),
    );
  }
}

class Punch2BButtonWidget extends ConsumerWidget {
  const Punch2BButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch2BProvider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch2BProvider.notifier).toggle(ref);
          if (ref.watch(punch2BProvider).isOn == true) {
            await ref.watch(audioProvider).playBodyCrossAudio();
            ref.read(punch2BProvider.notifier).addPunch2BToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k2B,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kBodyCrossPath,
          ),
        ),
      ),
    );
  }
}

class Punch3BButtonWidget extends ConsumerWidget {
  const Punch3BButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch3BProvider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch3BProvider.notifier).toggle(ref);
          if (ref.watch(punch3BProvider).isOn == true) {
            await ref.watch(audioProvider).playLeadBodyHookAudio();
            ref.read(punch3BProvider.notifier).addPunch3BToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k3B,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kLeadBodyHookPath,
          ),
        ),
      ),
    );
  }
}

class Punch4BButtonWidget extends ConsumerWidget {
  const Punch4BButtonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
        color: ref.watch(punch4BProvider).isOn
            ? Colors.greenAccent
            : Colors.transparent,
      ),
      child: InkWell(
        onTap: () async {
          //Every punchProvider has a number, corresponding to
          //original boxing methods (Jab = 1, Cross = 2, etc.).
          //If user selects a number, the punchProvider will set
          //to 'true' and if it's 'true', it should add the
          //corresponding punch number to the punchListProvider
          //and vice versa
          ref.read(punch4BProvider.notifier).toggle(ref);
          if (ref.watch(punch4BProvider).isOn == true) {
            await ref.watch(audioProvider).playRearBodyHookAudio();
            ref.read(punch4BProvider.notifier).addPunch4BToList(ref);
          } else {
            ref.read(punchListProvider.notifier).state.removeWhere(
                  (Punch punch) => punch.punchNumber == StringUtils.k4B,
                );
          }
        },
        child: const Image(
          image: AssetImage(
            StringUtils.kRearBodyHookPath,
          ),
        ),
      ),
    );
  }
}

class GloveWhenSelected extends StatelessWidget {
  final String image;
  const GloveWhenSelected({
    super.key,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: <Effect<dynamic>>[
        FadeEffect(
          delay: 0.ms,
          duration: 1500.ms,
        ),
        ScaleEffect(
          delay: 150.ms,
          duration: 1500.ms,
        ),
        TintEffect(
          delay: 300.ms,
          duration: 1500.ms,
          color: Colors.green.withOpacity(0.8),
        )
      ],
      child: Image(
        image: AssetImage(
          image,
        ),
      ),
    );
  }
}

class GloveWhenUnselected extends StatelessWidget {
  final String image;
  const GloveWhenUnselected({
    super.key,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: <Effect<dynamic>>[
        FadeEffect(
          delay: 0.ms,
          duration: 1500.ms,
        ),
        ScaleEffect(
          delay: 150.ms,
          duration: 1500.ms,
        ),
      ],
      child: Image(
        image: AssetImage(
          image,
        ),
      ),
    );
  }
}
