import 'package:boksklapps/all_imports.dart';

/// GetShitDoneWidget class
class GetShitDoneWidget extends ConsumerWidget {
  /// GetShitDoneWidget constructor
  const GetShitDoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        32,
        32,
        32,
        32,
      ),
      child: Column(
        children: <Row>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Animate>[
              Animate(
                effects: <Effect<dynamic>>[
                  FadeEffect(
                    delay: 0.ms,
                    duration: 1000.ms,
                  ),
                  MoveEffect(
                    delay: 500.ms,
                    duration: 1000.ms,
                  ),
                ],
                child: const Text(
                  StringUtils.kGet,
                  style: TextStyleUtils.kHeadline2,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Animate>[
              Animate(
                effects: <Effect<dynamic>>[
                  FadeEffect(
                    delay: 1000.ms,
                    duration: 1000.ms,
                  ),
                  MoveEffect(
                    delay: 1500.ms,
                    duration: 1000.ms,
                  ),
                ],
                child: const Text(
                  StringUtils.kShit,
                  style: TextStyleUtils.kHeadline2,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Animate>[
              Animate(
                effects: <Effect<dynamic>>[
                  FadeEffect(
                    delay: 2000.ms,
                    duration: 1000.ms,
                  ),
                  MoveEffect(
                    delay: 2500.ms,
                    duration: 1000.ms,
                  ),
                ],
                child: const Text(
                  StringUtils.kDone,
                  style: TextStyleUtils.kHeadline2,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Animate>[
              Animate(
                effects: <Effect<dynamic>>[
                  FadeEffect(
                    delay: 3000.ms,
                    duration: 1000.ms,
                  ),
                  MoveEffect(
                    delay: 3500.ms,
                    duration: 1000.ms,
                  ),
                ],
                child: Text(
                  ref.watch(userDisplayNameProvider),
                  style: TextStyleUtils.kHeadline2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
