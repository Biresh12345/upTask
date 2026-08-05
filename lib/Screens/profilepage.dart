import 'dart:io';

import 'package:UpTask/Screens/taskpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:UpTask/Screens/aboutpage.dart';
import 'package:UpTask/Screens/helpandsupportpage.dart';
import 'package:UpTask/Screens/remaindarpage.dart';

class Profilepage extends ConsumerWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    final todos = ref.watch(todoProvider);
    final completeCount = todos.where((todos) => todos.isCompleted).length;
    final pendingCount = todos.where((todos) => !todos.isCompleted).length;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/user.png', width: 80, height: 80),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Biresh Multani"),
                          Text("bireshmultani12345@gmail.com")
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text('${completeCount + pendingCount}'),
                            Text("Total Tasks"),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            width: 20,
                          ),
                        ),
                        Column(
                          children: [
                            Text(completeCount.toString()),
                            Text("Completed"),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            width: 20,
                          ),
                        ),
                        Column(
                          children: [
                            Text(pendingCount.toString()),
                            Text("Pending"),
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Remaindarpage(),
                              ));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications,
                            ),
                            const SizedBox(width: 10),
                            Text("Reminders"),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.grey, size: 20)
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.light_mode),
                          const SizedBox(width: 10),
                          Text("Theme"),
                        ],
                      ),
                      Row(
                        children: [
                          Text(isDark ? "Dark" : "Light"),
                          SizedBox(
                            height: 20,
                            child: Switch(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                value: isDark,
                                onChanged: (value) {
                                  ref
                                      .read(themeProvider.notifier)
                                      .setTheme(value);
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.backup),
                          const SizedBox(width: 10),
                          Text("Backup and Restore"),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.grey, size: 20)
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.settings),
                          const SizedBox(width: 10),
                          Text("Settings"),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.grey, size: 20)
                    ],
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Helpandsupportpage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.help_center_sharp),
                            const SizedBox(width: 10),
                            Text("Help and Support"),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 20)
                      ],
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Aboutpage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info),
                              const SizedBox(width: 10),
                              Text("About App"),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,
                              color: Colors.grey, size: 20)
                        ],
                      )),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    content: const Text("Are you sure to logout?"),
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
                          exit(0);
                        },
                        child: const Text("Close App"),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.logout),
                            const SizedBox(width: 10),
                            Text("Logout"),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 20)
                      ],
                    ),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
