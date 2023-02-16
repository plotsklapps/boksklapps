import '../../all_imports.dart';

/// PasswordScreenTablet class
class PasswordScreenTablet extends StatefulWidget {
  /// PasswordScreenTablet constructor
  const PasswordScreenTablet({
    super.key,
  });

  @override
  State<PasswordScreenTablet> createState() => PasswordScreenTabletState();
}

/// PasswordScreenTabletState class
class PasswordScreenTabletState extends State<PasswordScreenTablet> {
  /// EmailController
  final TextEditingController emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
            18,
            54,
            18,
            54,
          ),
          child: Row(
            children: <Expanded>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Row>[
                    Row(
                      children: const <Widget>[
                        GetShitDoneWidget(),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const <Text>[
                            Text(
                              'RESET PASSWORD',
                              style: TextStyleUtils.kHeadline1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        /// Email TextField
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
                    Column(
                      children: const <Widget>[
                        BackToLoginWidget(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await resetPassword(
              context,
              emailCtrl.text,
            );
          },
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
