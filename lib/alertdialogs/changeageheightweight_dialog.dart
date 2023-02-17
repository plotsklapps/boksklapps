import 'package:boksklapps/all_imports.dart';

/// Shows a dialog to change the email address
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

                /// Age Textfield (reads ageProvider)
                TextField(
                  controller: ageCtrl,
                  onChanged: (String age) {
                    ref.read(ageProvider.notifier).state = int.parse(age);
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: ref.read(ageProvider).toString(),
                    prefixIcon: const Icon(
                      Icons.cake_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Height in cm'),

                /// Height Textfield (reads heightProvider)
                TextField(
                  controller: heightCtrl,
                  onChanged: (String height) {
                    ref.read(heightProvider.notifier).state = int.parse(height);
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: ref.read(heightProvider).toString(),
                    prefixIcon: const Icon(
                      Icons.height_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Weight in kg'),

                // Weight Textfield (updates weightProvider)
                TextField(
                  controller: weightCtrl,
                  onChanged: (String weight) {
                    ref.read(weightProvider.notifier).state = int.parse(weight);
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: ref.read(weightProvider).toString(),
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
                        ref.read(bmiProvider.notifier).state = calculateBMI();
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
                  // Store the age, height, weight and bmi values  retrieved
                  // from the corresponding Providers in the Firestore
                  // database for the current user
                  final String? userUID = ref.watch(currentUserProvider)?.uid;
                  final int age = ref.watch(ageProvider);
                  final int height = ref.watch(heightProvider);
                  final int weight = ref.watch(weightProvider);
                  final double bmi = ref.watch(bmiProvider) ?? 0.0;

                  await ref
                      .watch(firestoreProvider)
                      .collection('users')
                      .doc(userUID)
                      .set(<String, dynamic>{
                    'userAge': age,
                    'userHeight': height,
                    'userWeight': weight,
                    'userBMI': bmi,
                  }).then((_) {
                    // Show a snackbar to confirm that the values have been
                    // updated and pop the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Age / Height / Weight / BMI updated',
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
