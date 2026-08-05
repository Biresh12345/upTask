import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/models/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notificationpage extends ConsumerWidget {
  const Notificationpage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationData = ref.watch(notificationProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.clear_all,
              color: theme.colorScheme.onBackground,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showMaterialBanner(
                MaterialBanner(
                  content: const Text(
                      "Are you sure you want to clear all notifications?"),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        ref
                            .read(notificationProvider.notifier)
                            .clearNotification();
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                      },
                      child: const Text("Okay"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: notificationData.isEmpty
            ? const Text("No notifications")
            : ListView.builder(
                itemCount: notificationData.length,
                itemBuilder: (context, index) {
                  final notification = notificationData[index];
                  return buildNotificationTile(
                    notification,
                  );
                },
              ),
      ),
    );
  }

  Widget buildNotificationTile(
    AppNotification notification,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.deepPurple.withOpacity(.1),
          child: const Icon(
            Icons.notifications_active,
            color: Colors.deepPurple,
          ),
        ),
        title: Text(
          notification.title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6),
            Text(notification.body!),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  "${notification.createdAt}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
