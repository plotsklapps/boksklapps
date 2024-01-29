import 'package:flutter_riverpod/flutter_riverpod.dart';

final NotifierProvider<SneakPeekNotifier, bool> isSneakPeeker =
    NotifierProvider<SneakPeekNotifier, bool>(SneakPeekNotifier.new);

class SneakPeekNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  bool setTrue() {
    return state = true;
  }

  bool setFalse() {
    return state = false;
  }
}
