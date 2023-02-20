import 'package:boksklapps/all_imports.dart';

// Shows a dialog to change the age, height, weight and BMI
// and store it to Firestore
Future<void> showChangeUserBMIDialog(
  BuildContext context,
) async {
  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController ageCtrl = TextEditingController();
      final TextEditingController heightCtrl = TextEditingController();
      final TextEditingController weightCtrl = TextEditingController();

      // Method to calculate and store age, height, weight and BMI to
      // their corresponding Providers and Firestore
      Future<void> calculateBMIAndStoreData(WidgetRef ref) async {
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
            await ref.read(userBMIProvider.notifier).updateUserBMI(
                  context,
                  ref,
                  UserBMIRepository().calculateUserBMI(
                    ref.watch(userHeightProvider),
                    ref.watch(userWeightProvider),
                  ),
                );
          });
        });
      }

      // Return Consumer() to gain access to the Providers
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          return AlertDialog(
            title: const Text(
              'BMI Calculator',
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Age in years'),

                // Age Textfield (watches ageProvider)
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

                // Height Textfield (watches heightProvider)
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

                // Weight Textfield (watches weightProvider)
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
                        Logger().i(
                          'Calculating BMI...',
                        );
                        // Store age, height and weight to
                        // their corresponding Providers and Firestore
                        // and calculate BMI and store this as well
                        await calculateBMIAndStoreData(ref);
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
                    'Saving age, height, weight and BMI to Firestore...',
                  );
                  // Store values to Firestore database via
                  // their corresponding Providers ALSO if user
                  // did not click on the Calculate BMI button at
                  // all!
                  await calculateBMIAndStoreData(ref).then((_) async {
                    // Show a snackbar to confirm that the values have been
                    // updated and pop the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Age, height, weight and BMI updated...',
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
    },
  );
}
