import 'package:UpTask/Screens/viewtaskpage.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/models/notes.dart';
import 'package:intl/intl.dart';

class Viewalltaskpage extends ConsumerWidget {
  final List<Todo> todos;
  const Viewalltaskpage({super.key, required this.todos});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("View All Task"),
      ),
      body: todos.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 72,
                    color: theme.colorScheme.outline.withAlpha(120),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "All caught up!",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Viewtaskpage(todos: todo),
                      ),
                    );
                  },
                  child: _buildTodoCard(
                    context,
                    index: index,
                    todo: todo,
                    ref: ref,
                  ),
                );
              },
            ),
    );
  }

  Widget _buildTodoCard(BuildContext context,
      {required int index, required Todo todo, WidgetRef? ref}) {
    final isDone = todo.isCompleted;
    // final isAlarmRinging = ref.watch(controlAlarmProvider);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                todo.catergoryIcon != null
                    ? Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(todo.catergoryIcon!.color),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                            color: Colors.white,
                            IconData(
                              todo.catergoryIcon!.icon,
                              fontFamily: CupertinoIcons.book.fontFamily,
                              fontPackage: CupertinoIcons.book.fontPackage,
                            )),
                      )
                    : SizedBox(
                        height: 24,
                      ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isDone ? Colors.green.shade100 : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isDone ? "Completed" : "Pending",
                    style: TextStyle(
                      color: isDone ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          todo.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.alarm,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${todo.hours?.toString().padLeft(2, '0') ?? '00'}:"
                        "${todo.minutues?.toString().padLeft(2, '0') ?? '00'}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (todo.description != null &&
                      todo.description!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      todo.description!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        decoration: isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        DateFormat("dd MMM yyyy").format(todo.dueDate!),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      if (todo.priority != null)
                        Wrap(spacing: 8, children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                  color: todo.priority == "Low"
                                      ? Colors.red
                                      : todo.priority == "Medium"
                                          ? Colors.orange
                                          : Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    todo.priority!,
                                    style: const TextStyle(color: Colors.white),
                                  )))
                        ])
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case "edit":
                        // _showAddTodoBottomSheet(
                        //   context,
                        //   index,
                        //   todo: todo,
                        // );
                        break;

                      case "delete":
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                            content: const Text("Delete tasks?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentMaterialBanner();
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await Alarm.stop(todo.id!);
                                  ref!
                                      .read(todoProvider.notifier)
                                      .deleteTodo(index);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentMaterialBanner();
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          ),
                        );

                        break;

                      case "share":
                        // Share Todo
                        break;
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: "edit",
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text("Edit"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "share",
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(width: 8),
                          Text("Share"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "delete",
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                todo.isCompleted == false
                    ? Checkbox(
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        value: isDone,
                        onChanged: (_) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content: const Text(
                                  "Are you Sure complete this task?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                  },
                                  child: const Text("Undo"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await Alarm.stop(todo.id!);
                                    ref!
                                        .read(todoProvider.notifier)
                                        .toggle(todo);
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 30,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
