import 'package:boksklapps/all_imports.dart';

/// SneakPeakWidget class
class SneakPeakWidget extends StatelessWidget {
  /// SneakPeakWidget constructor
  const SneakPeakWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <InkWell>[
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/home_screen',
            );
          },
          child: Animate(
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
              'Sneak Peek',
              style: TextStyleUtils.kHeadline3,
            ),
          ),
        ),
      ],
    );
  }
}
