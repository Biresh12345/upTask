import 'package:hive/hive.dart';
part 'categoryIcons.g.dart';

@HiveType(typeId: 1)
class Categoryicons extends HiveObject {
  @HiveField(0)
  final int icon;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int color;

  Categoryicons({
    required this.icon,
    required this.name,
    required this.color,
  });

  Categoryicons copyWith({
    int? icon,
    String? name,
    int? color,
  }) {
    return Categoryicons(
      icon: icon ?? this.icon,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }
}
