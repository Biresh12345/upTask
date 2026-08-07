import 'package:UpTask/Screens/taskpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final defaultPriorityProvider = StateProvider<String>((ref) => "Medium");

final defaultReminderProvider = StateProvider<int>((ref) => -1);

class Settingpage extends ConsumerStatefulWidget {
  const Settingpage({super.key});

  @override
  ConsumerState<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends ConsumerState<Settingpage> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider);
    final defaultPriority = ref.watch(defaultPriorityProvider);
    final defaultReminder = ref.watch(defaultReminderProvider);
    final applock = ref.watch(applockProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode),
                  title: const Text("Dark Theme"),
                  subtitle: Text(isDark ? "Enabled" : "Disabled"),
                  value: isDark,
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).setTheme(value);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Notifications
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SwitchListTile(
              secondary: const Icon(Icons.notifications),
              title: const Text("Enable Notifications"),
              subtitle: const Text("Receive reminders"),
              value: true,
              onChanged: (v) {},
            ),
          ),

          const SizedBox(height: 15),

          // Task
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ListTile(
                    leading: const Icon(Icons.flag),
                    title: const Text("Default Priority"),
                    subtitle: Text(defaultPriority),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Select Priority"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text("Low"),
                                  onTap: () {
                                    ref
                                        .read(defaultPriorityProvider.notifier)
                                        .state = "Low";
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text("Medium"),
                                  onTap: () {
                                    ref
                                        .read(defaultPriorityProvider.notifier)
                                        .state = "Medium";
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text("High"),
                                  onTap: () {
                                    ref
                                        .read(defaultPriorityProvider.notifier)
                                        .state = "High";
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.schedule),
                  title: const Text("Default Reminder Time"),
                  subtitle: defaultReminder == -1
                      ? const Text("Off")
                      : defaultReminder == 0
                          ? const Text("At Task Time")
                          : defaultReminder == 1440
                              ? const Text("1 day before")
                              : Text("$defaultReminder minutes before"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Default Reminder Time"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text("At Task Time"),
                                onTap: () {
                                  ref
                                      .read(defaultReminderProvider.notifier)
                                      .state = 0;
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("5 minutes before"),
                                onTap: () {
                                  ref
                                      .read(defaultReminderProvider.notifier)
                                      .state = 5;
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("10 minutes before"),
                                onTap: () {
                                  ref
                                      .read(defaultReminderProvider.notifier)
                                      .state = 10;
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("15 minutes before"),
                                onTap: () {
                                  ref
                                      .read(defaultReminderProvider.notifier)
                                      .state = 15;
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("30 minutes before"),
                                onTap: () {
                                  ref
                                      .read(defaultReminderProvider.notifier)
                                      .state = 30;
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("1 hour before"),
                                onTap: () {
                                  ref
                                      .read(defaultReminderProvider.notifier)
                                      .state = 60;
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("1 day before"),
                                onTap: () {
                                  ref
                                      .read(defaultReminderProvider.notifier)
                                      .state = 1440;
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("Off"),
                                onTap: () {
                                  ref
                                      .read(defaultReminderProvider.notifier)
                                      .state = -1;
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Security
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.lock),
                  title: const Text("App Lock"),
                  value: applock,
                  onChanged: (v) {
                    ref.read(applockProvider.notifier).setapplock(v);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Language
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Language"),
              subtitle: const Text("English"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),

          const SizedBox(height: 15),

          // Data
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.upload_file),
                  title: const Text("Export Tasks"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.cleaning_services),
                  title: const Text("Clear Cache"),
                  trailing: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          Center(
            child: Text(
              "App Version 1.0.0",
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
