import 'package:UpTask/models/categoryIcons.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'notes.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? dueDate;

  @HiveField(6)
  final int? hours;

  @HiveField(7)
  final int? minutues;

  @HiveField(8)
  Categoryicons? catergoryIcon;

  @HiveField(9)
  final String? priority;

  @HiveField(10)
  final bool? remainderme;

  @HiveField(11)
  final int? alarmBefore;

  Todo(
      {this.id,
      required this.title,
      this.description,
      this.isCompleted = false,
      DateTime? createdAt,
      this.dueDate,
      this.hours,
      this.minutues,
      this.catergoryIcon,
      this.priority,
      this.remainderme,
      this.alarmBefore = 0})
      : createdAt = createdAt ?? DateTime.now();

  Todo copyWith(
      {int? id,
      String? title,
      String? description,
      bool? isCompleted,
      DateTime? createdAt,
      DateTime? dueDate,
      int? hours,
      int? minutues,
      Categoryicons? catergoryIcon,
      String? priority,
      bool? remainderme,
      int? alarmBefore}) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt ?? this.createdAt,
        dueDate: dueDate ?? this.dueDate,
        hours: hours ?? this.hours,
        minutues: minutues ?? this.minutues,
        catergoryIcon: catergoryIcon ?? this.catergoryIcon,
        priority: priority ?? this.priority,
        remainderme: remainderme ?? this.remainderme,
        alarmBefore: alarmBefore ?? this.alarmBefore);
  }
}
