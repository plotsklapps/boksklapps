import '../all_imports.dart';

/// Total Time Provider
final StateProvider<Duration> totalTimeProvider =
    StateProvider<Duration>((StateProviderRef<Duration> ref) {
  return const Duration(minutes: 30);
});

/// Set Time Provider
final StateProvider<Duration> setTimeProvider =
    StateProvider<Duration>((StateProviderRef<Duration> ref) {
  return const Duration(minutes: 3);
});

/// Rest Time Provider
final StateProvider<Duration> restTimeProvider =
    StateProvider<Duration>((StateProviderRef<Duration> ref) {
  return const Duration(seconds: 30);
});
