import 'package:UpTask/Screens/addtaskpage.dart';
import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/models/categoryIcons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:UpTask/Screens/addcategorypage.dart';
import 'package:UpTask/constant/constant.dart';
import 'package:UpTask/models/notes.dart';

class Catergorypage extends ConsumerWidget {
  final bool? fromAddTask;
  const Catergorypage({super.key, this.fromAddTask});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryData = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Category"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: categoryData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final category = categoryData[index];

          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(category.color).withOpacity(.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Constant.icons[category.icon],
                  size: 35,
                  color: Color(category.color),
                ),
                const SizedBox(height: 8),
                Text(category.name),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Add Category"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Addcategorypage(),
            ),
          );
        },
      ),
    );
  }
}
