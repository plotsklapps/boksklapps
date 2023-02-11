import 'package:boksklapps/all_imports.dart';

/// PasswordScreenDesktop class
class PasswordScreenDesktop extends StatefulWidget {
  /// PasswordScreenDesktop constructor
  const PasswordScreenDesktop({
    super.key,
  });

  @override
  State<PasswordScreenDesktop> createState() => PasswordScreenDesktopState();
}

/// PasswordScreenDesktopState class
class PasswordScreenDesktopState extends State<PasswordScreenDesktop> {
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
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 4,
          64,
          MediaQuery.of(context).size.width / 4,
          56,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Row>[
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
                children: <Widget>[
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
