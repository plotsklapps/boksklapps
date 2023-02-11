import 'package:boksklapps/all_imports.dart';

/// Age Provider for age/height/weight alert dialog
final ageProvider = StateProvider<int>((ref) {
  return 0;
});

/// Height Provider for age/height/weight alert dialog
final heightProvider = StateProvider<int>((ref) {
  return 0;
});

/// Weight Provider for age/height/weight alert dialog
final weightProvider = StateProvider<int>((ref) {
  return 0;
});

/// BMI Provider for age/height/weight alert dialog
final bmiProvider = StateProvider<double>((ref) {
  return 0.0;
});
