import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:UpTask/models/categoryIcons.dart';

class Categoryiconsprovider extends Notifier<Categoryicons?> {
  @override
  Categoryicons? build() {
    return null;
  }

  void setCategory(Categoryicons category) {
    state = category;
  }

  void clear() {
    state = null;
  }
}
