import 'package:UpTask/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/models/notes.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  List<Todo> upTask = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todos = ref.watch(todoProvider);
    final upTask = ref.watch(todoProvider.notifier).listWiseDate(selectedDate);

    final completeCount = todos
        .where((todo) =>
            ref
                .read(todoProvider.notifier)
                .isSameDate(todo.dueDate, selectedDate) &&
            todo.isCompleted)
        .length;

    final pendingCount = todos
        .where((todo) =>
            ref
                .read(todoProvider.notifier)
                .isSameDate(todo.dueDate, selectedDate) &&
            !todo.isCompleted)
        .length;

    final total = completeCount + pendingCount;

    final progress = total == 0 ? 0.0 : completeCount / total;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DatePicker(
                  theme: DatePickerPlusTheme(
                    headerTheme: HeaderTheme(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  minDate: DateTime(2020),
                  maxDate: DateTime(2035),
                  // initialDate: selectedDate,
                  onDateSelected: (date) async {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Selected Date",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.calendar_month),
                ),
                title: Text(
                  DateFormat("EEEE, dd MMM yyyy").format(selectedDate),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Today's Progress",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Completed"),
                        Text("${completeCount} / ${pendingCount} Tasks"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Tasks",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upTask.length,
              itemBuilder: (context, index) {
                final todo = upTask[index];

                final priorityColor = todo.priority == "Low"
                    ? Colors.green
                    : todo.priority == "Medium"
                        ? Colors.orange
                        : Colors.red;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        // Category Icon
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(todo.catergoryIcon!.color),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            todo.catergoryIcon != null
                                ? Constant.icons[todo.catergoryIcon!.icon]
                                : Icons.task,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),

                        const SizedBox(width: 14),

                        // Task Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todo.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              if (todo.description != null &&
                                  todo.description!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    todo.description!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${todo.hours?.toString().padLeft(2, '0')}:${todo.minutues?.toString().padLeft(2, '0')}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(
                                    Icons.flag,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: priorityColor.withOpacity(.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      todo.priority ?? "Normal",
                                      style: TextStyle(
                                        color: priorityColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Status
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: todo.isCompleted
                                ? Colors.green.withOpacity(.15)
                                : Colors.orange.withOpacity(.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            todo.isCompleted ? "Done" : "Open",
                            style: TextStyle(
                              color: todo.isCompleted
                                  ? Colors.green
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
