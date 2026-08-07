import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class Applockcontroller extends Notifier<bool> {
  late Box box;

  @override
  bool build() {
    return Hive.box("Settings").get("isLock", defaultValue: false);
  }

  void setapplock(bool value) {
    final appsetting = Hive.box("Settings");
    appsetting.put('isLock', value);
    state = value;
  }
}
