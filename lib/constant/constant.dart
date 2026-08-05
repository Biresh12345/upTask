import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:UpTask/models/categoryIcons.dart';

class Constant {
  static const String appVersion = "1.0";

  static List<Categoryicons> categories = [
    Categoryicons(
      name: "Work",
      icon: CupertinoIcons.briefcase_fill.codePoint,
      color: Colors.blue.value,
    ),
    Categoryicons(
      name: "Personal",
      icon: CupertinoIcons.person_fill.codePoint,
      color: Colors.red.value,
    ),
    Categoryicons(
      name: "Health",
      icon: CupertinoIcons.heart_fill.codePoint,
      color: Colors.green.value,
    ),
    Categoryicons(
      name: "Study",
      icon: CupertinoIcons.book_fill.codePoint,
      color: Colors.purple.value,
    ),
    Categoryicons(
      name: "Shopping",
      icon: CupertinoIcons.shopping_cart.codePoint,
      color: Colors.orange.value,
    ),
    Categoryicons(
      name: "Travel",
      icon: CupertinoIcons.airplane.codePoint,
      color: Colors.pink.value,
    ),
    Categoryicons(
      name: "Home",
      icon: CupertinoIcons.house_fill.codePoint,
      color: Colors.teal.value,
    ),
    Categoryicons(
      name: "Fitness",
      icon: CupertinoIcons.sportscourt_fill.codePoint,
      color: Colors.deepOrange.value,
    ),
    Categoryicons(
      name: "Food",
      icon: CupertinoIcons.cart_fill.codePoint,
      color: Colors.amber.value,
    ),
    Categoryicons(
      name: "Finance",
      icon: CupertinoIcons.money_dollar_circle_fill.codePoint,
      color: Colors.greenAccent.value,
    ),
    Categoryicons(
      name: "Movie",
      icon: CupertinoIcons.film_fill.codePoint,
      color: Colors.indigo.value,
    ),
    Categoryicons(
      name: "Music",
      icon: CupertinoIcons.music_note.codePoint,
      color: Colors.deepPurple.value,
    ),
    Categoryicons(
      name: "Meeting",
      icon: CupertinoIcons.person_2_fill.codePoint,
      color: Colors.cyan.value,
    ),
    Categoryicons(
      name: "Birthday",
      icon: CupertinoIcons.gift_fill.codePoint,
      color: Colors.pinkAccent.value,
    ),
    Categoryicons(
      name: "Pets",
      icon: CupertinoIcons.paw.codePoint,
      color: Colors.brown.value,
    ),
    Categoryicons(
      name: "Car",
      icon: CupertinoIcons.car_detailed.codePoint,
      color: Colors.blueGrey.value,
    ),
    Categoryicons(
      name: "Phone",
      icon: CupertinoIcons.phone_fill.codePoint,
      color: Colors.lightGreen.value,
    ),
    Categoryicons(
      name: "Ideas",
      icon: CupertinoIcons.lightbulb_fill.codePoint,
      color: Colors.yellow.value,
    ),
    Categoryicons(
      name: "Photos",
      icon: CupertinoIcons.camera_fill.codePoint,
      color: Colors.deepPurpleAccent.value,
    ),
    Categoryicons(
      name: "Other",
      icon: CupertinoIcons.square_grid_2x2_fill.codePoint,
      color: Colors.grey.value,
    ),
  ];

  static final priorities = [
    ("Low", Colors.red),
    ("Medium", Colors.orange),
    ("High", Colors.green),
  ];

  static const String aboutApp = '''
About Todo App

Todo App is a simple and efficient task management application designed to help you stay organized and productive. Whether you're managing personal tasks, work projects, or daily routines, Todo App makes it easy to keep everything in one place.

Key Features

• Create, edit, and delete tasks
• Organize tasks with categories
• Set due dates and reminders
• Mark tasks as completed
• Search and filter tasks
• Track completed and pending tasks
• Beautiful analytics dashboard
• Light & Dark mode support
• Secure local data storage
• Fast and user-friendly interface

Why Choose Todo App?

Our goal is to provide a clean, simple, and reliable task management experience without unnecessary complexity. Your tasks are stored locally on your device, ensuring quick access even without an internet connection.

Privacy

Your privacy matters.
All task data is stored locally on your device. We do not collect, share, or upload your personal information.

Version

Version: 1.0.0

Developed With

• Flutter
• Riverpod
• Hive Database
• Material 3 Design

Thank You

Thank you for choosing Todo App.
We hope it helps you stay organized, productive, and achieve your daily goals.
''';

  static const String helpSupport = '''
Welcome to Todo App!

Thank you for using our application. This app helps you organize your daily tasks, manage reminders, and improve productivity.

Frequently Asked Questions

1. How do I create a new task?
• Tap the "+" button.
• Enter the task title and description.
• Choose a category, date, and time.
• Tap "Save Task".

2. How do I edit a task?
• Open the task.
• Tap the Edit button.
• Make your changes.
• Save the task.

3. How do I delete a task?
• Swipe the task left or tap the Delete icon.
• Confirm the deletion.

4. How do reminders work?
• Select a due date and time while creating a task.
• Enable reminders.
• You'll receive a notification when it's time.

5. How do I mark a task as completed?
• Tap the checkbox next to the task.
• Completed tasks will move to the completed section.

6. Is my data safe?
Yes. All your tasks are stored locally on your device. Your personal information is never shared.

7. How can I change the app theme?
Go to Settings > Theme and choose Light or Dark Mode.

8. Can I recover deleted tasks?
Deleted tasks cannot be recovered unless you restore them from a backup.

Need More Help?

If you're experiencing issues or have suggestions, please contact us.

Email:
support@todoapp.com

Working Hours:
Monday - Friday
9:00 AM - 6:00 PM

Thank you for choosing Todo App!
Stay organized and productive.
''';
}
