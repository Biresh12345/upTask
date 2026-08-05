import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:alarm/model/notification_settings.dart';
import 'package:alarm/model/volume_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:UpTask/constant/constant.dart';
import 'package:UpTask/models/notes.dart';

class TodoController extends Notifier<List<Todo>> {
  late Box<Todo> box;
  late bool celenderToggle;
  List<Todo> _upTask = [];

  @override
  List<Todo> build() {
    box = Hive.box<Todo>("todoBox");
    _upTask = box.values.toList();
    return box.values.toList();
  }

  Future<void> addTodo(Todo todo) async {
    await box.add(todo);
    _upTask = box.values.toList();
    state = box.values.toList();
  }

  Future<void> deleteTodo(int index) async {
    await box.deleteAt(index);
    state = box.values.toList();
  }

  Future<void> updateTodo(int index, Todo todo) async {
    await box.putAt(index, todo);
    state = box.values.toList();
  }

  Future<void> deleteAll() async {
    await box.clear();
    state = box.values.toList();
  }

  Future<void> toggle(Todo todo) async {
    final index = box.values.toList().indexOf(todo);
    await box.putAt(index, (todo.copyWith(isCompleted: !todo.isCompleted)));
    state = box.values.toList();
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = box.values.toList();
      return;
    }

    final searchQuery = query.toLowerCase();

    state = box.values.where((todo) {
      return todo.title.toLowerCase().contains(searchQuery) ||
          (todo.description?.toLowerCase().contains(searchQuery) ?? false);
    }).toList();
  }

  List<Todo> listWiseDate(DateTime date) {
    return _upTask.where((todo) {
      if (todo.dueDate == null) return false;
      return todo.dueDate!.year == date.year &&
          todo.dueDate!.month == date.month &&
          todo.dueDate!.day == date.day;
    }).toList();
  }

  bool isSameDate(DateTime? a, DateTime b) {
    if (a == null) return false;

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<Todo> upcomingRemainder() {
    final now = DateTime.now();

    final remainderNow = _upTask.where((todo) {
      if (todo.dueDate == null) return false;
      return todo.dueDate!.isAfter(now);
    }).toList();

    return remainderNow;
  }
}
