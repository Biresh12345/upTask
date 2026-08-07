import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/Screens/viewtaskpage.dart';
import 'package:UpTask/models/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Notificationpage extends ConsumerWidget {
  const Notificationpage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final notificationData = ref.watch(notificationProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        leading: IconButton(icon: Icon(Icons.arrow_back) ,onPressed: (){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },),
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
                  return GestureDetector(
                    onTap: () {
                      final index =
                          todos.indexWhere((e) => e.id == notification.id);
                      if (index != -1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Viewtaskpage(
                              todos: todos[index],
                              index: index,
                            ),
                          ),
                        );
                        ref
                            .read(notificationProvider.notifier)
                            .updateReadNotification(notification, index);
                      }
                    },
                    child: buildNotificationTile(
                      notification,
                    ),
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
            notification.title ?? "Notification",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Text(notification.body ?? "You have a new notification"),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    DateFormat('dd MMM yyyy').format(
                      notification.createdAt ?? DateTime.now(),
                    ),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          trailing: Text(notification.isRead ? "Read" : "Unread")),
    );
  }
}
