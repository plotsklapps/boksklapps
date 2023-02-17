import 'package:boksklapps/all_imports.dart';

/// Age Provider for age/height/weight alert dialog

final ageProvider = StateProvider<Future<int>>((ref) {
  return UserAgeRepository().getUserAge().then((userAge) {
    return userAge;
  });
});

/// Height Provider for age/height/weight alert dialog
final StateProvider<int> heightProvider =
    StateProvider<int>((StateProviderRef<int> ref) {
  return 0;
});

/// Weight Provider for age/height/weight alert dialog
final StateProvider<int> weightProvider =
    StateProvider<int>((StateProviderRef<int> ref) {
  return 0;
});

/// BMI Provider for age/height/weight alert dialog
final StateProvider<double> bmiProvider =
    StateProvider<double>((StateProviderRef<double> ref) {
  return 0.0;
});
