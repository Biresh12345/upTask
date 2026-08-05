import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends Notifier<bool> {
  late Box box;

  @override
  bool build() {
    box = Hive.box("Settings");
    return box.get("isDark", defaultValue: false);
  }

  void setTheme(bool value) {
    box.put('isDark', value);
    state = value;
  }
}
