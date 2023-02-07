import 'package:boksklapps/all_imports.dart';

/// PasswordScreenMobile class
class PasswordScreenMobile extends StatefulWidget {
  /// PasswordScreenMobile constructor
  const PasswordScreenMobile({
    super.key,
  });

  @override
  State<PasswordScreenMobile> createState() => PasswordScreenMobileState();
}

/// PasswordScreenMobileState class
class PasswordScreenMobileState extends State<PasswordScreenMobile> {
  /// EmailController
  final TextEditingController emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          18,
          54,
          18,
          54,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
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
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                children: [
                  const Text(
                    'RESET PASSWORD',
                    style: TextStyleUtils.kHeadline1,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: StringUtils.kLabelEmail,
                      prefixIcon: IconUtils.kEmailAddress,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (emailCtrl.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email cannot be empty'),
              ),
            );
            return;
          } else {
            await Navigator.pushReplacementNamed(
              context,
              '/home_screen',
            );
          }
        },
        child: IconUtils.kForward,
      ),
    );
  }
}
