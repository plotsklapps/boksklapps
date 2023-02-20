import 'package:boksklapps/all_imports.dart';

// Shows a dialog to change the age, height, weight and BMI
// Method takes context and ref as parameter to have access
// to both
Future<void> showChangeUserBMIDialog(
  BuildContext context,
  WidgetRef ref,
) async {
  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController ageCtrl = TextEditingController();
      final TextEditingController heightCtrl = TextEditingController();
      final TextEditingController weightCtrl = TextEditingController();

      return AlertDialog(
        title: const Text(
          'BMI Calculator',
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Age in years'),

            // Age Textfield (stores value to ageProvider)
            TextField(
              controller: ageCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: ref.watch(userAgeProvider),
                prefixIcon: const Icon(
                  Icons.cake_outlined,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text('Height in cm'),

            // Height Textfield (stores value to heightProvider)
            TextField(
              controller: heightCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: ref.watch(userHeightProvider),
                prefixIcon: const Icon(
                  Icons.height_outlined,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text('Weight in kg'),

            // Weight Textfield (stores value to weightProvider)
            TextField(
              controller: weightCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: ref.watch(userWeightProvider),
                prefixIcon: const Icon(
                  Icons.monitor_weight_outlined,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    // Need to store height and weight to
                    // their corresponding Providers first
                    // before calculating BMI
                    await ref
                        .read(userHeightProvider.notifier)
                        .updateUserHeight(
                          context,
                          ref,
                          heightCtrl.text,
                        )
                        .then((_) async {
                      await ref
                          .read(userWeightProvider.notifier)
                          .updateUserWeight(
                            context,
                            ref,
                            weightCtrl.text,
                          )
                          .then((_) async {
                        // Call the method to calculate BMI
                        // and store the value to the corresponding
                        // Provider and Firestore database
                        final String userBMI =
                            UserBMIRepository().calculateUserBMI(
                          ref.watch(userHeightProvider),
                          ref.watch(userWeightProvider),
                        );
                        await ref.read(userBMIProvider.notifier).updateUserBMI(
                              context,
                              ref,
                              userBMI,
                            );
                      });
                    });
                  },
                  child: const Text(
                    'Calculate BMI',
                  ),
                ),
                Text(
                  // Show the newly calculated BMI in the dialog
                  ref.watch(userBMIProvider),
                  style: TextStyleUtils.kHeadline3,
                ),
              ],
            ),
          ],
        ),
        actions: <TextButton>[
          TextButton(
            child: const Text(
              'Cancel',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Save',
            ),
            onPressed: () async {
              Logger().i(
                'User clicked to save data...',
              );
              // Store values to Firestore database via
              // their corresponding Providers
              await ref
                  .read(userAgeProvider.notifier)
                  .updateUserAge(
                    context,
                    ref,
                    ageCtrl.text,
                  )
                  .then((_) async {
                await ref.read(userHeightProvider.notifier).updateUserHeight(
                      context,
                      ref,
                      heightCtrl.text,
                    );
              }).then((_) async {
                await ref.read(userWeightProvider.notifier).updateUserWeight(
                      context,
                      ref,
                      weightCtrl.text,
                    );
              }).then((_) async {
                // Show a snackbar to confirm that the values have been
                // updated and pop the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Age / Height / Weight / BMI updated...',
                    ),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  ),
                );
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      );
    },
  );
}
