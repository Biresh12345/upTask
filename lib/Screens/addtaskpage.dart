import 'dart:math';
import 'package:UpTask/constant/constant.dart';
import 'package:UpTask/models/categoryIcons.dart';
import 'package:UpTask/models/notification.dart';
import 'package:UpTask/services/localnotificationcservice.dart';
import 'package:UpTask/widget/prioritychip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:UpTask/Screens/categorypage.dart';
import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/models/notes.dart';
import 'package:UpTask/widget/textField.dart';

final timepickProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());
final datepickProvider = StateProvider<DateTime>((ref) => DateTime.now());

final remainderState = StateProvider<bool>((ref) => true);

final priorityState = StateProvider<String>((ref) => "");

final selectedCategoryProvider = StateProvider<Categoryicons?>((ref) => null);

class Addtaskpage extends ConsumerStatefulWidget {
  final Todo? todo;
  final int? index;

  const Addtaskpage({super.key, this.todo, this.index});

  @override
  ConsumerState<Addtaskpage> createState() => _AddtaskpageState();
}

class _AddtaskpageState extends ConsumerState<Addtaskpage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.todo?.description ?? '');

    if (widget.todo != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(selectedCategoryProvider.notifier).state =
            widget.todo!.catergoryIcon!;

        ref.read(datepickProvider.notifier).state =
            widget.todo!.dueDate ?? DateTime.now();

        ref.read(timepickProvider.notifier).state = TimeOfDay(
          hour: widget.todo!.hours ?? TimeOfDay.now().hour,
          minute: widget.todo!.minutues ?? TimeOfDay.now().minute,
        );

        ref.read(priorityState.notifier).state = widget.todo!.priority ?? "";
        ref.read(remainderState.notifier).state =
            widget.todo!.remainderme ?? false;
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(selectedCategoryProvider.notifier).state = null;
        ref.read(datepickProvider.notifier).state = DateTime.now();
        ref.read(timepickProvider.notifier).state = TimeOfDay.now();
        ref.read(priorityState.notifier).state = "";
        ref.read(remainderState.notifier).state = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _resetFields() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final theme = Theme.of(context);
    final pickTime = ref.watch(timepickProvider);
    final pickDate = ref.watch(datepickProvider);
    final isRemainder = ref.watch(remainderState);
    final priority = ref.watch(priorityState);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.todo == null ? "Add New Task" : "Edit Task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final category = await Navigator.push<Categoryicons>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Catergorypage(
                      fromAddTask: true,
                    ),
                  ),
                );
                if (category != null) {
                  ref.read(selectedCategoryProvider.notifier).state = category;
                }
              },
              child: selectedCategory != null
                  ? Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(selectedCategory.color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        IconData(
                          selectedCategory.icon,
                          fontFamily: CupertinoIcons.shopping_cart.fontFamily,
                          fontPackage: CupertinoIcons.shopping_cart.fontPackage,
                        ),
                        color: Color(selectedCategory.color),
                        size: 35,
                      ),
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.edit),
                    ),
            ),
            const SizedBox(height: 8),

            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Task Title",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Textfield(
                    controller: _titleController,
                    labelText: "e.g. book flight ticket",
                  ),
                ],
              ),
            ),

            // Description Container
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Textfield(
                    controller: _descriptionController,
                    labelText: "Add more details about this task....",
                  ),
                ],
              ),
            ),

            // Task Details Container (Date, Time, Category, Priority)
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: pickDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (picked == null) return;
                      ref.read(datepickProvider.notifier).state = picked;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 10),
                            Text("Date",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                "${pickDate.day}/${pickDate.month}/${pickDate.year}",
                                style: TextStyle(fontSize: 16)),
                            Icon(Icons.arrow_forward_ios, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: pickTime,
                      );
                      if (pickedTime == null) return;
                      ref.read(timepickProvider.notifier).state = pickedTime;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.access_time),
                            SizedBox(width: 10),
                            Text("Time",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(pickTime.format(context).toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Icon(Icons.arrow_forward_ios, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.drag_indicator),
                          SizedBox(width: 10),
                          Text("Priority",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: Constant.priorities
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: PriorityChip(
                                  title: e.$1,
                                  color: e.$2,
                                  isSelected: priority == e.$1,
                                  onTap: () {
                                    ref.read(priorityState.notifier).state =
                                        e.$1;
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Reminder Toggle Container
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Set Reminder",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: isRemainder,
                    onChanged: (value) {
                      ref.read(remainderState.notifier).state = value;
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Action Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.maxFinite,
              child: FloatingActionButton.extended(
                backgroundColor: theme.colorScheme.primaryContainer,
                label: Text(widget.todo == null ? "Add Task" : "Update Task"),
                onPressed: () async {
                  if (_titleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                        backgroundColor: Colors.yellow[300],
                        content:
                            const Text("Please enter a title for the task"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner();
                            },
                            child: const Text("Okay"),
                          ),
                        ],
                      ),
                    );

                    return;
                  }

                  if (_descriptionController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Enter a description"),
                      ),
                    );
                    return;
                  }

                  final selectedIcon = ref.read(categoryProvider);

                  if (selectedIcon == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a category"),
                      ),
                    );
                    return;
                  }

                  if (selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a category")),
                    );
                    return;
                  }

                  final updatedTodo = Todo(
                    id: widget.todo?.id ?? Random().nextInt(2147483647),
                    title: _titleController.text,
                    description: _descriptionController.text,
                    isCompleted: widget.todo?.isCompleted ?? false,
                    createdAt: DateTime.now(),
                    catergoryIcon: selectedCategory,
                    dueDate: pickDate,
                    hours: pickTime.hour,
                    minutues: pickTime.minute,
                    priority: priority,
                    remainderme: isRemainder,
                  );

                  final notification = AppNotification(
                    id: Random().nextInt(2147483647),
                    title: updatedTodo.title,
                    body: updatedTodo.description,
                    createdAt: DateTime.now(),
                  );

                  if (widget.todo == null) {
                    ref.read(todoProvider.notifier).addTodo(updatedTodo);
                    ref.read(selectedCategoryProvider.notifier).state = null;
                    await Localnotificationcservice.showNotification(
                      title: "✅ Task Added",
                      body: "${updatedTodo.title} has been added successfully.",
                    );
                    ref
                        .read(notificationProvider.notifier)
                        .addNotification(notification);
                  } else {
                    if (widget.index != null) {
                      ref
                          .read(todoProvider.notifier)
                          .updateTodo(widget.index!, updatedTodo);
                      await Localnotificationcservice.showNotification(
                        title: "✏️ Task Updated",
                        body:
                            "${updatedTodo.title} has been updated successfully.",
                      );
                    }
                  }

                  ref.read(timeProvider.notifier).scheduleAlarm(updatedTodo);
                  _resetFields();
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker() {
    return DatePickerDialog(
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
  }
}
