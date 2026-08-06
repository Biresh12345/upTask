import 'package:UpTask/constant/constant.dart';
import 'package:UpTask/models/categoryIcons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class Categoryiconsprovider extends Notifier<List<Categoryicons>> {
  late Box<Categoryicons> box;

  @override
  List<Categoryicons> build() {
    box = Hive.box<Categoryicons>("categoryIcons");
    addDefaultCategory();
    return box.values.toList();
  }

  void addDefaultCategory() {
    if (box.isEmpty) {
      box.addAll(Constant.categories);
    }
    state = box.values.toList();
  }

  void addCategory(Categoryicons category) {
    box.add(category);
    state = box.values.toList();
  }
}
