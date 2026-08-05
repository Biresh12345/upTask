import 'package:hive/hive.dart';
part 'categoryIcons.g.dart';

@HiveType(typeId: 1)
class Categoryicons {
  @HiveField(0)
  final int icon;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int color;

  const Categoryicons({
    required this.icon,
    required this.name,
    required this.color,
  });
}
