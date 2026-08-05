import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/models/notes.dart';

class Timeprovider extends Notifier<DateTime> {
  Timer? _timer;
  DateTime get now => state;

  @override
  DateTime build() {
    return DateTime.now();
  }

  Future<void> scheduleAlarm(Todo? todo) async {
    if (todo == null ||
        todo.dueDate == null ||
        todo.hours == null ||
        todo.minutues == null ||
        todo.id == null) {
      return;
    }

    if (!todo.remainderme!) {
      await Alarm.stop(todo.id!);
      return;
    }

    await Alarm.stop(todo.id!);

    final alarmTime = DateTime(
      todo.dueDate!.year,
      todo.dueDate!.month,
      todo.dueDate!.day,
      todo.hours!,
      todo.minutues!,
    );
    if (alarmTime.isBefore(DateTime.now())) {
      await Alarm.stop(todo.id!);
      return;
    }

    final alarmSettings = AlarmSettings(
      notificationSettings: NotificationSettings(
        title: 'Alarm',
        body: 'Alarm is ringing',
        icon: 'ic_launcher',
      ),
      id: todo.id!,
      dateTime: DateTime(
        todo.dueDate!.year,
        todo.dueDate!.month,
        todo.dueDate!.day,
        todo.hours!,
        todo.minutues!,
      ),
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: false,
      vibrate: true,
      warningNotificationOnKill: true,
      androidFullScreenIntent: true,
      volumeSettings: VolumeSettings.fade(fadeDuration: Duration(seconds: 2)),
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }
}
