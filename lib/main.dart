import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/models/categoryIcons.dart';
import 'package:UpTask/models/notification.dart';
import 'package:UpTask/services/localnotificationcservice.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:UpTask/models/notes.dart';
import 'package:UpTask/widget/bottomnavigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CategoryiconsAdapter());
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(AppNotificationAdapter());

  await Hive.openBox<Todo>("todoBox");
  await Hive.openBox("Settings");
  await Hive.openBox<AppNotification>("notification");

  await Alarm.init();

  await Alarm.stopAll();

  await Localnotificationcservice.initialize();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        title: 'UpTask',
        debugShowCheckedModeBanner: false,
        home: BottomNavScreen());
  }
}
