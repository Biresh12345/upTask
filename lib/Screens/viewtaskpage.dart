import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:UpTask/models/notes.dart';

class Viewtaskpage extends StatelessWidget {
  final Todo todos;

  const Viewtaskpage({
    super.key,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Category Icon
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                IconData(
                  todos.catergoryIcon!.icon ??
                      CupertinoIcons.check_mark.codePoint,
                  fontFamily: CupertinoIcons.shopping_cart.fontFamily,
                  fontPackage: CupertinoIcons.shopping_cart.fontPackage,
                ),
                size: 42,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 24),

            _buildTile(
              icon: Icons.title,
              title: "Title",
              value: todos.title,
            ),

            _buildTile(
              icon: Icons.description,
              title: "Description",
              value: todos.description!,
            ),

            _buildTile(
              icon: Icons.calendar_month,
              title: "Due Date",
              value: todos.dueDate == null
                  ? "Not Selected"
                  : DateFormat("dd MMM yyyy").format(todos.dueDate!),
            ),

            _buildTile(
              icon: Icons.access_time,
              title: "Reminder Time",
              value: (todos.hours == null || todos.minutues == null)
                  ? "Not Selected"
                  : "${todos.hours!.toString().padLeft(2, '0')}:${todos.minutues!.toString().padLeft(2, '0')}",
            ),

            _buildTile(
              icon: Icons.event_available,
              title: "Created On",
              value: DateFormat(
                "dd MMM yyyy",
              ).format(todos.createdAt),
            ),

            _buildTile(
              icon: Icons.check_circle,
              title: "Status",
              value: todos.isCompleted ? "Completed" : "Pending",
              valueColor: todos.isCompleted ? Colors.green : Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: valueColor,
            ),
          ),
        ),
      ),
    );
  }
}
