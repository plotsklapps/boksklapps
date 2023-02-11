import 'package:boksklapps/all_imports.dart';

/// DrawerWidget class
class DrawerWidget extends StatelessWidget {
  /// DrawerWidget constructor
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 220,
            child: DrawerHeader(
              child: Column(
                children: <Row>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Animate>[
                      Animate(
                        effects: <Effect<dynamic>>[
                          ScaleEffect(
                            delay: 0.ms,
                            duration: 800.ms,
                          ),
                        ],
                        child: const Text(
                          StringUtils.kBoks,
                          style: TextStyleUtils.kLogo1,
                        ),
                      ),
                      Animate(
                        effects: <Effect<dynamic>>[
                          ScaleEffect(
                            delay: 800.ms,
                            duration: 800.ms,
                          ),
                        ],
                        child: const Text(
                          StringUtils.kKlapps,
                          style: TextStyleUtils.kLogo2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Animate>[
                      Animate(
                        effects: <Effect<dynamic>>[
                          FadeEffect(
                            delay: 1600.ms,
                            duration: 800.ms,
                          ),
                        ],
                        child: const Text(
                          StringUtils.kSparringPartner,
                          style: TextStyleUtils.kHeadline2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          ListTile(
            title: const Text(
              'Account',
              style: TextStyleUtils.kBodyText,
            ),
            subtitle: const Text('Change credential information'),
            trailing: IconUtils.kAccount,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/account_screen',
              );
            },
          ),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyleUtils.kBodyText,
            ),
            subtitle: const Text('Change app look & feel'),
            trailing: IconUtils.kSettings,
            onTap: () async {
              await Navigator.pushNamed(
                context,
                '/settings_screen',
              );
            },
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyleUtils.kBodyText,
            ),
            subtitle: const Text('Sign out from the app'),
            trailing: IconUtils.kLogout,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                await Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
