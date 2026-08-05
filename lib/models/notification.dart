import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 2)
class AppNotification extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? body;

  @HiveField(3)
  final DateTime? createdAt;

  AppNotification({this.id, this.title, this.body, this.createdAt});

  AppNotification copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
