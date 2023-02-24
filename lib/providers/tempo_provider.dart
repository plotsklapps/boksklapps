import 'package:boksklapps/all_imports.dart';

final StateNotifierProvider<TempoDoubleNotifier, double> tempoDoubleProvider =
    StateNotifierProvider<TempoDoubleNotifier, double>(
        (StateNotifierProviderRef<TempoDoubleNotifier, double> ref) {
  return TempoDoubleNotifier();
});

class TempoDoubleNotifier extends StateNotifier<double> {
  TempoDoubleNotifier() : super(2.0);

  Future<void> setTempoDouble(double newValue, WidgetRef ref) async {
    state = newValue;
    ref.read(tempoStringProvider.notifier).setTempoString(ref);
  }
}

final StateNotifierProvider<TempoStringNotifier, String> tempoStringProvider =
    StateNotifierProvider<TempoStringNotifier, String>(
        (StateNotifierProviderRef<TempoStringNotifier, String> ref) {
  return TempoStringNotifier();
});

class TempoStringNotifier extends StateNotifier<String> {
  TempoStringNotifier() : super('Moderate');

  void setTempoString(WidgetRef ref) {
    if (ref.watch(tempoDoubleProvider) == 1.0) {
      state = 'Easy';
    } else if (ref.watch(tempoDoubleProvider) == 2.0) {
      state = 'Moderate';
    } else if (ref.watch(tempoDoubleProvider) == 3.0) {
      state = 'Fast';
    } else {
      state = 'Ridiculous';
    }
  }
}
