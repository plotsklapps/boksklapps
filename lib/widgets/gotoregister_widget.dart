import 'package:boksklapps/all_imports.dart';

class GoToRegisterWidget extends StatelessWidget {
  const GoToRegisterWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/register_screen',
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
          StringUtils.kCreateAccount,
          style: TextStyleUtils.kHeadline3,
        ),
      ),
    );
  }
}
