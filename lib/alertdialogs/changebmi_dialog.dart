import 'package:boksklapps/all_imports.dart';

/// Shows a dialog to change the age, height, weight and BMI
/// Method takes context as parameter
Future<void> showChangeAgeHeightWeight(BuildContext context) async {
  /// Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      /// Consumer widget to access the providers
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          /// AgeController
          final TextEditingController ageCtrl = TextEditingController();

          /// HeightController
          final TextEditingController heightCtrl = TextEditingController();

          /// WeightController
          final TextEditingController weightCtrl = TextEditingController();

          /// Method to calculate the BMI (returns a double)
          double calculateBMI() {
            final double height = double.parse(heightCtrl.text) / 100;
            final double weight = double.parse(weightCtrl.text);
            final double calculatedBMI = weight / (height * height);

            return calculatedBMI;
          }

          return AlertDialog(
            title: const Text(
              'Age / Height / Weight',
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
                    labelText: ref.watch(ageProvider).toString(),
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
                    labelText: ref.watch(heightProvider).toString(),
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
                    labelText: ref.watch(weightProvider).toString(),
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
                      // Press to set value calculated in calculatedBMI
                      // to bmiProvider
                      onPressed: () {
                        // Store the values from the TextFields to the
                        // corresponding Providers
                        ref.read(bmiProvider.notifier).state = calculateBMI();
                        ref.read(ageProvider.notifier).state =
                            UserAgeRepository().getUserAge();
                        ref.read(heightProvider.notifier).state =
                            int.parse(heightCtrl.text);
                        ref.read(weightProvider.notifier).state =
                            int.parse(weightCtrl.text);
                      },
                      child: const Text(
                        'Calculate BMI',
                      ),
                    ),
                    Text(
                      // Show the newly calculated BMI in the dialog
                      ref.watch(bmiProvider).toStringAsFixed(2),
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
                  // Store the age, height, weight and BMI values
                  // retrieved from the corresponding Providers to the
                  // Firestore database for the current user via
                  // updateFirestoreData method
                  Logger().i(
                    'Updating all Firestore data...',
                  );
                  try {
                    final int age = int.parse(ageCtrl.text);
                    await ref.read(userAgeProvider.notifier).updateUserAge(
                          context,
                          age,
                        );
                    await updateFirestoreData(context, ref).then((_) {
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
                  } catch (error) {
                    Logger().i(
                      'Something went wrong... $error',
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Something went wrong... $error',
                        ),
                        action: SnackBarAction(label: 'OK', onPressed: () {}),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}
