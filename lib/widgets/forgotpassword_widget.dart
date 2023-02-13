import 'package:boksklapps/all_imports.dart';

/// ForgotPasswordWidget class
class ForgotPasswordWidget extends StatelessWidget {
  /// ForgotPasswordWidget constructor
  const ForgotPasswordWidget({
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
              '/password_screen',
            );
          },
          child: Animate(
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
              StringUtils.kForgotPassword,
              style: TextStyleUtils.kHeadline3,
            ),
          ),
        ),
      ],
    );
  }
}
