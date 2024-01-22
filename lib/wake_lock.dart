import 'dart:js' as js;

void keepScreenAwake() {
  js.context.callMethod('eval', ['navigator.wakeLock.request("screen")']);
}
