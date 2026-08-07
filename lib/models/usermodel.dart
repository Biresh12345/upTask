import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class Usermodel extends HiveObject {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? password;

  Usermodel({this.name, this.email, this.password});

  Usermodel copyWith({String? name, String? email, String? password}) {
    return Usermodel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
