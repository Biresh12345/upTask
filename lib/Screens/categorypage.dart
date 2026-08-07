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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Select Category"),
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Addcategorypage(),
                  ),
                );
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(24)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  margin: EdgeInsets.all(12),
                  child: Center(child: Icon(Icons.add),)))
        ],
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

          return GestureDetector(
            onTap: () {
              if (fromAddTask == true) {
                Navigator.pop(context, category);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Addtaskpage(
                      categoryicons: category,
                    ),
                  ),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 0.2,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Delete Category"),
                              content: const Text(
                                  "Are you sure you want to delete this category?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref
                                        .read(categoryProvider.notifier)
                                        .deleteCategory(category);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.red.withOpacity(.8),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(category.color).withOpacity(0.5),
                  ),
                    child: Icon(
                      Constant.icons[category.icon],
                      size: 35,
                      color: Color(category.color),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(category.name),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
