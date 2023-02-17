import 'package:boksklapps/all_imports.dart';

/// DrawerWidget class
class DrawerWidget extends ConsumerWidget {
  /// DrawerWidget constructor
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Column>[
          Column(
            children: <SizedBox>[
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
            ],
          ),
          Column(
            children: <ListTile>[
              ListTile(
                title: const Text(
                  'Account',
                  style: TextStyleUtils.kBodyText,
                ),
                subtitle: const Text('Change credential information'),
                trailing: IconUtils.kAccount,
                onTap: () async {
                  /// Navigate to account screen
                  await Navigator.pushNamed(
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
                  /// Navigate to settings screen
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
                  // Sign out from Firebase
                  await ref.read(firebaseProvider).signOut();

                  // Clear the currentUserProvider
                  ref.invalidate(currentUserProvider);

                  // Clear all screens, show snackbar to user
                  // and return to splash screen
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'You have been signed out...',
                        ),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ),
                    );
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
        ],
      ),
    );
  }
}
