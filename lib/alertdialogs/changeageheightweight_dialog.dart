import 'package:boksklapps/all_imports.dart';

/// Shows a dialog to change the email address
/// Method takes context as parameter
Future<void> showChangeAgeHeightWeight(BuildContext context) async {
  // Show the dialog
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, ref, _) {
          /// AgeController
          final ageCtrl = TextEditingController();
          final heightCtrl = TextEditingController();
          final weightCtrl = TextEditingController();

          double calculateBMI() {
            final height = double.parse(heightCtrl.text) / 100;
            final weight = double.parse(weightCtrl.text);
            final calculatedBMI = weight / (height * height);

            return calculatedBMI;
          }

          return AlertDialog(
            title: const Text(
              'Age / Height / Weight',
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: ageCtrl,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    prefixIcon: Icon(
                      Icons.cake_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: heightCtrl,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: 'Height in CM',
                    prefixIcon: Icon(
                      Icons.height_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: weightCtrl,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: 'Weight in KGS',
                    prefixIcon: Icon(
                      Icons.monitor_weight_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.read(bmiProvider.notifier).state = calculateBMI();
                      },
                      child: const Text(
                        'Calculate BMI',
                      ),
                    ),
                    Text(
                      ref.watch(bmiProvider).toStringAsFixed(1),
                      style: TextStyleUtils.kHeadline3,
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text(
                  'Cancel',
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Save',
                ),
                onPressed: () async {
                  ref.read(ageProvider.notifier).state = ageCtrl as int;
                  ref.read(heightProvider.notifier).state = heightCtrl as int;
                  ref.read(weightProvider.notifier).state = weightCtrl as int;
                  ref.read(bmiProvider.notifier).state = ref.watch(bmiProvider);
                  await Navigator.pushReplacementNamed(
                    context,
                    '/login_screen',
                  );
                },
              ),
            ],
          );
        },
      );
    },
  );
}
