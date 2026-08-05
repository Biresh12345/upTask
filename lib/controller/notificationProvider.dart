import 'package:UpTask/models/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class Notificationprovider extends Notifier<List<AppNotification>> {
  late Box<AppNotification> box;
  @override
  List<AppNotification> build() {
    box = Hive.box<AppNotification>("notification");
    return box.values.toList();
  }

  Future<void> addNotification(AppNotification notification) async {
    await box.add(notification);
    state = box.values.toList();
  }

  void deleteNotification(AppNotification notification) {
    int index = state.indexOf(notification);
    state.removeAt(index);
  }

  void clearNotification() {
    state = [];
  }
}
