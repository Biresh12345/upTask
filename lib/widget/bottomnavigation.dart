import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:UpTask/Screens/calendarpage.dart';
import 'package:UpTask/Screens/categorypage.dart';
import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/Screens/profilepage.dart';

final bottomNavProvider = StateProvider<int>((ref) => 0);

class BottomNavScreen extends ConsumerWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);
    final theme = Theme.of(context);

    final pages = [
      Taskpage(),
      CalendarPage(),
      Catergorypage(),
      Profilepage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        height: 70,
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: Colors.grey,
        onDestinationSelected: (index) {
          ref.read(bottomNavProvider.notifier).state = index;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.task_outlined),
            selectedIcon: Icon(Icons.task),
            label: "Tasks",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: "Calendar",
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: "Categories",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
