import 'package:boksklapps/all_imports.dart';

/// BackToLoginWidget class
class BackToLoginWidget extends StatelessWidget {
  /// BackToLoginWidget constructor
  const BackToLoginWidget({
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
              '/login_screen',
            );
          },
          child: Animate(
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
              StringUtils.kBackToLogin,
              style: TextStyleUtils.kHeadline3,
            ),
          ),
        ),
      ],
    );
  }
}
