import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Screens/taskpage.dart';
class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final completed = todos.where((e) => e.isCompleted).length;
    final pending = todos.where((e) => !e.isCompleted).length;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// Avatar
            Stack(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/user.png"),
                ),

                Positioned(
                  right: 0,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Text(
              "Biresh Multani",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "bireshmultani12345@gmail.com",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: statCard(
                    title: "Total",
                    value: todos.length.toString(),
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: statCard(
                    title: "Completed",
                    value: completed.toString(),
                    color: Colors.green,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: statCard(
                    title: "Pending",
                    value: pending.toString(),
                    color: Colors.orange,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget statCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 5),
          Text(title),
        ],
      ),
    );
  }
}