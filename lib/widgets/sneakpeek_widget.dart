import 'package:boksklapps/all_imports.dart';

/// SneakPeakWidget class
class SneakPeekWidget extends StatelessWidget {
  /// SneakPeakWidget constructor
  const SneakPeekWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <InkWell>[
        InkWell(
          onTap: () async {
            await Navigator.pushNamed(
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
