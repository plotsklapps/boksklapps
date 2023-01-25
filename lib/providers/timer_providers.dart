import 'package:boksklapps/all_imports.dart';

/// Total Time Provider
final totalTimeProvider = StateProvider<Duration>((ref) {
  return const Duration(minutes: 30);
});

/// Set Time Provider
final setTimeProvider = StateProvider<Duration>((ref) {
  return const Duration(minutes: 3);
});

/// Rest Time Provider
final restTimeProvider = StateProvider<Duration>((ref) {
  return const Duration(seconds: 30);
});
