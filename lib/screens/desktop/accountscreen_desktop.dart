import 'package:boksklapps/all_imports.dart';

class AccountScreenDesktop extends ConsumerWidget {
  const AccountScreenDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: StringUtils.kAccount,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Row(
            children: <Widget>[
              const DrawerWidget(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    GetShitDoneWidget(),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <ListTile>[
                    ListTile(
                      title: Text(
                        ref.watch(userEmailProvider),
                      ),
                      subtitle: const Text(
                        'UserEmail',
                      ),
                      trailing: const Icon(
                        Icons.edit_outlined,
                      ),
                      onTap: () async {
                        // If the user is logged in, show the dialog to change
                        // the email address
                        if (ref.watch(userEmailProvider) == 'Sneak Peeker') {
                          await showNoAccountDialog(context);
                        } else {
                          await showChangeEmailDialog(
                            context,
                            ref,
                          );
                        }
                      },
                    ),
                    ListTile(
                      title: Text(
                        ref.watch(userDisplayNameProvider) ??
                            StringUtils.kNoAccount,
                      ),
                      subtitle: const Text(
                        'UserName',
                      ),
                      trailing: const Icon(
                        Icons.edit_outlined,
                      ),
                      onTap: () async {
                        // If the user is logged in, show the dialog to change
                        // the username
                        if (ref.watch(userEmailProvider) == 'Sneak Peeker') {
                          await showNoAccountDialog(context);
                        } else {
                          await showChangeUserDisplayNameDialog(
                            context,
                            ref,
                          );
                        }
                      },
                    ),
                    ListTile(
                      title: Text(
                        ref.watch(userBMIProvider),
                      ),
                      subtitle: const Text(
                        'BMI',
                      ),
                      trailing: const Icon(
                        Icons.edit_outlined,
                      ),
                      onTap: () async {
                        // If the user is logged in, show the dialog to change
                        // the age, height, weight and calculate BMI
                        if (ref.watch(userEmailProvider) == 'Sneak Peeker') {
                          await showNoAccountDialog(context);
                        } else {
                          await showChangeUserBMIDialog(
                            context,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
