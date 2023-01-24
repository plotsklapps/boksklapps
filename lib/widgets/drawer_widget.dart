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
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  StringUtils.kBoks,
                  style: TextStyleUtils.kLogo1,
                ),
                Text(
                  StringUtils.kKlapps,
                  style: TextStyleUtils.kLogo2,
                ),
              ],
            ),
          ),
          const Spacer(),
          ListTile(
            title: const Text(
              'Account',
              style: TextStyleUtils.kBodyText,
            ),
            subtitle: const Text('Change credential information'),
            trailing: const Icon(IconUtils.kAccount),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyleUtils.kBodyText,
            ),
            subtitle: const Text('Change app look & feel'),
            trailing: const Icon(IconUtils.kSettings),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyleUtils.kBodyText,
            ),
            subtitle: const Text('Sign out from the app'),
            trailing: const Icon(IconUtils.kLogout),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
