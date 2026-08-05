import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:UpTask/Screens/notificationpage.dart';
import 'package:UpTask/Screens/viewtaskpage.dart';
import 'package:UpTask/controller/notificationProvider.dart';
import 'package:UpTask/controller/themeprovider.dart';
import 'package:UpTask/models/notification.dart';
import 'package:UpTask/services/localnotificationcservice.dart';
import 'package:UpTask/widget/prioritychip.dart';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:alarm/model/notification_settings.dart';
import 'package:alarm/model/volume_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:UpTask/Screens/addtaskpage.dart';
import 'package:UpTask/Screens/categorypage.dart';
import 'package:UpTask/Screens/viewalltaskpage.dart';
import 'package:UpTask/constant/constant.dart';
import 'package:UpTask/controller/categoryIcons.dart';
import 'package:UpTask/controller/controlalarm.dart';
import 'package:UpTask/controller/homeProvider.dart';
import 'package:UpTask/controller/timeprovider.dart';
import 'package:UpTask/models/categoryIcons.dart';
import 'package:UpTask/models/notes.dart';
import 'package:UpTask/widget/bottomnavigation.dart';
import 'package:UpTask/widget/drawerlabel.dart';
import 'package:UpTask/widget/textField.dart';
import 'package:UpTask/widget/timetext.dart';

final todoProvider = NotifierProvider<TodoController, List<Todo>>(
  TodoController.new,
);

final categoryIconProvider =
    NotifierProvider<Categoryiconsprovider, Categoryicons?>(
  Categoryiconsprovider.new,
);

final timeProvider = NotifierProvider<Timeprovider, DateTime>(
  Timeprovider.new,
);

final controlAlarmProvider = NotifierProvider<Controlalarm, bool>(
  Controlalarm.new,
);

final themeProvider = NotifierProvider<ThemeProvider, bool>(
  ThemeProvider.new,
);

final notificationProvider =
    NotifierProvider<Notificationprovider, List<AppNotification>>(
  Notificationprovider.new,
);

class Taskpage extends ConsumerStatefulWidget {
  const Taskpage({super.key});

  @override
  ConsumerState<Taskpage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Taskpage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchtextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showButton = true;
  StreamSubscription<AlarmSettings>? _alarmSubscription;
  final alarms = Alarm.getAlarms();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _searchtextController.dispose();
    _alarmSubscription?.cancel();
    super.dispose();
  }

  Future<void> _resetFields() async {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  initState() {
    super.initState();
    _resetFields();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          setState(() {
            _showButton = false;
          });
        } else {
          setState(() {
            _showButton = true;
          });
        }
      } else {
        setState(() {
          _showButton = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);
    final theme = Theme.of(context);
    final completeCount = todos.where((todos) => todos.isCompleted).length;
    final pendingCount = todos.where((todos) => !todos.isCompleted).length;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notification = ref.watch(notificationProvider);
    final notificationCount = notification.length;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "My Tasks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          todos.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Notificationpage(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.notifications),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Text(notificationCount.toString()),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Textfield(
              controller: _searchtextController,
              filled: true,
              fillcolor: Colors.white,
              icon: Icons.search,
              suffixIcon: Icons.tune,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              labelText: "Search for a task",
              onChanged: (value) {
                ref.read(todoProvider.notifier).search(value!);
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  width: MediaQuery.sizeOf(context).width / 2.4,
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            border: Border.all(
                              color: Colors.purple,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Icon(Icons.check_box, color: Colors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Done",
                            style: TextStyle(
                                color: isDark ? Colors.black : Colors.grey),
                          ),
                          Text(
                            completeCount.toString(),
                            style: TextStyle(
                                color: isDark ? Colors.black : Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Tasks",
                            style: TextStyle(
                                color: isDark ? Colors.black : Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.sizeOf(context).width / 2.4,
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.orange,
                            ),
                            color: Colors.orange.shade100,
                          ),
                          child: Icon(Icons.watch_later, color: Colors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Open",
                            style: TextStyle(
                                color: isDark ? Colors.black : Colors.grey),
                          ),
                          Text(
                            pendingCount.toString(),
                            style: TextStyle(
                                color: isDark ? Colors.black : Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Tasks",
                            style: TextStyle(
                                color: isDark ? Colors.black : Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Tasks",
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Viewalltaskpage(
                          todos: todos,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        "View all",
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: todos.isEmpty
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
                    controller: _scrollController,
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: _showButton
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text("New Task"),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Addtaskpage(),
                  ),
                );
              },
            )
          : SizedBox(),
    );
  }

  Widget _buildTodoCard(BuildContext context,
      {required int index, required Todo todo}) {
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
                    isDone ? "Done" : "Open",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Addtaskpage(
                              index: index,
                              todo: todo,
                            ),
                          ),
                        );
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
                                  ref
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
                                    ref
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
                        Icons.done_rounded,
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
