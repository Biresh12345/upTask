import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:UpTask/models/categoryIcons.dart';

class Constant {
  static const String appVersion = "1.0";

  static List<Categoryicons> categories = [
    Categoryicons(
      name: "Work",
      icon: 0,
      color: Colors.blue.value,
    ),
    Categoryicons(
      name: "Personal",
      icon: 1,
      color: Colors.red.value,
    ),
    Categoryicons(
      name: "Health",
      icon: 2,
      color: Colors.green.value,
    ),
    Categoryicons(
      name: "Study",
      icon: 3,
      color: Colors.purple.value,
    ),
    Categoryicons(
      name: "Shopping",
      icon: 4,
      color: Colors.orange.value,
    ),
  ];

  static final priorities = [
    ("Low", Colors.red),
    ("Medium", Colors.orange),
    ("High", Colors.green),
  ];

  static const colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.lime,
    Colors.amber,
    Colors.brown,
    Colors.grey,
  ];

  static const List<IconData> icons = [
    // Work & Business
    CupertinoIcons.briefcase_fill,
    CupertinoIcons.briefcase,
    CupertinoIcons.person_fill,
    CupertinoIcons.person,
    CupertinoIcons.person_2_fill,
    CupertinoIcons.person_3_fill,

    // Home
    CupertinoIcons.house_fill,
    CupertinoIcons.house,

    // Health
    CupertinoIcons.heart_fill,
    CupertinoIcons.heart,
    CupertinoIcons.bandage_fill,

    // Education
    CupertinoIcons.book_fill,
    CupertinoIcons.book,
    CupertinoIcons.bookmark_fill,
    CupertinoIcons.bookmark,

    // Shopping
    CupertinoIcons.cart_fill,
    CupertinoIcons.cart,
    CupertinoIcons.shopping_cart,
    CupertinoIcons.bag_fill,
    CupertinoIcons.bag,

    // Finance
    CupertinoIcons.money_dollar_circle_fill,
    CupertinoIcons.money_dollar_circle,
    CupertinoIcons.creditcard_fill,
    CupertinoIcons.creditcard,

    // Travel
    CupertinoIcons.airplane,
    CupertinoIcons.car_fill,
    CupertinoIcons.car_detailed,
    CupertinoIcons.bus,
    CupertinoIcons.train_style_one,

    // Sports
    CupertinoIcons.sportscourt_fill,
    CupertinoIcons.sportscourt,
    CupertinoIcons.game_controller,
    CupertinoIcons.game_controller_solid,

    // Entertainment
    CupertinoIcons.film_fill,
    CupertinoIcons.film,
    CupertinoIcons.music_note,
    CupertinoIcons.music_note_2,
    CupertinoIcons.tv_fill,
    CupertinoIcons.tv,

    // Pets
    CupertinoIcons.paw,
    // Communication
    CupertinoIcons.phone_fill,
    CupertinoIcons.phone,
    CupertinoIcons.chat_bubble_fill,
    CupertinoIcons.chat_bubble,
    CupertinoIcons.envelope_fill,
    CupertinoIcons.envelope,

    // Ideas
    CupertinoIcons.lightbulb_fill,
    CupertinoIcons.lightbulb,

    // Camera
    CupertinoIcons.camera_fill,
    CupertinoIcons.camera,
    CupertinoIcons.photo_fill,
    CupertinoIcons.photo,

    // Files
    CupertinoIcons.doc_fill,
    CupertinoIcons.doc,
    CupertinoIcons.folder_fill,
    CupertinoIcons.folder,

    // Map
    CupertinoIcons.map_fill,
    CupertinoIcons.map,
    CupertinoIcons.location_fill,
    CupertinoIcons.location,
    CupertinoIcons.globe,

    // Time
    CupertinoIcons.clock_fill,
    CupertinoIcons.clock,
    CupertinoIcons.calendar,
    CupertinoIcons.calendar_today,

    // Notifications
    CupertinoIcons.bell_fill,
    CupertinoIcons.bell,

    // Favorites
    CupertinoIcons.star_fill,
    CupertinoIcons.star,
    CupertinoIcons.flag_fill,
    CupertinoIcons.flag,
    CupertinoIcons.tag_fill,
    CupertinoIcons.tag,

    // Connectivity
    CupertinoIcons.wifi,
    CupertinoIcons.bluetooth,
    CupertinoIcons.antenna_radiowaves_left_right,

    // Battery
    CupertinoIcons.battery_100,
    CupertinoIcons.battery_25,
    CupertinoIcons.battery_0,
    CupertinoIcons.battery_charging,

    // Security
    CupertinoIcons.lock_fill,
    CupertinoIcons.lock,
    CupertinoIcons.lock_open,
    CupertinoIcons.shield_fill,
    CupertinoIcons.shield,

    // Settings
    CupertinoIcons.settings,
    CupertinoIcons.gear,
    CupertinoIcons.slider_horizontal_3,

    // Weather
    CupertinoIcons.sun_max_fill,
    CupertinoIcons.sun_max,
    CupertinoIcons.moon_fill,
    CupertinoIcons.moon,
    CupertinoIcons.cloud_fill,
    CupertinoIcons.cloud,
    CupertinoIcons.cloud_rain_fill,

    // Food
    CupertinoIcons.cube_box_fill,
    CupertinoIcons.cube_box,

    // Misc
    CupertinoIcons.scissors,
    CupertinoIcons.paintbrush_fill,
    CupertinoIcons.paintbrush,
    CupertinoIcons.wand_stars,
    CupertinoIcons.sparkles,
    CupertinoIcons.flame_fill,
    CupertinoIcons.flame,
    CupertinoIcons.gift_fill,
    CupertinoIcons.gift,
    CupertinoIcons.square_grid_2x2_fill,
    CupertinoIcons.square_grid_2x2,
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
