import 'package:flutter_riverpod/flutter_riverpod.dart';

final NotifierProvider<SneakPeekerNotifier, bool> isSneakPeekerProvider =
    NotifierProvider<SneakPeekerNotifier, bool>(SneakPeekerNotifier.new);

class SneakPeekerNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  bool setTrue() {
    return true;
  }

  bool setFalse() {
    return false;
  }
}
