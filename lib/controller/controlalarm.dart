import 'package:flutter_riverpod/flutter_riverpod.dart';

class Controlalarm extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setAlarm(bool value) {
    state = value;
  }

  void toggleAlarm() {
    state = !state;
  }
}
