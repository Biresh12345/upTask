import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/controller/timeprovider.dart';

class TimeText extends ConsumerWidget {
  const TimeText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);
    return Text("${time.hour}:${time.minute.toString().padLeft(2, '00')}");
  }
}
