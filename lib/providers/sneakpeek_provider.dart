import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final sneakPeekProvider =
    NotifierProvider.autoDispose<SneakPeekNotifier, bool>(() {
  return SneakPeekNotifier();
});

class SneakPeekNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  Future<void> setSneakPeek({required bool isSneakPeeker}) async {
    state = isSneakPeeker;
  }
}
