import 'package:boksklapps/all_imports.dart';

/// GetShitDoneWidget class
class GetShitDoneWidget extends StatelessWidget {
  /// GetShitDoneWidget constructor
  const GetShitDoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        32,
        32,
        32,
        32,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
            children: [
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
            children: [
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
        ],
      ),
    );
  }
}
