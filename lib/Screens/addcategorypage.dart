import 'package:UpTask/constant/constant.dart';
import 'package:UpTask/widget/textField.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryColorProvider = StateProvider<Color?>((ref) => null);
final categoryIconProvider = StateProvider<IconData?>((ref) => null);
final categoryNameProvider = StateProvider<String?>((ref) => null);

class Addcategorypage extends ConsumerStatefulWidget {
  const Addcategorypage({super.key});

  @override
  ConsumerState<Addcategorypage> createState() => _AddcategorypageState();
}

class _AddcategorypageState extends ConsumerState<Addcategorypage> {
  final _categorytitleController = TextEditingController();

  @override
  initState() {
    super.initState();
    ref.listenManual<String?>(
      categoryNameProvider,
      (previous, next) {
        if (next != null) {
          _categorytitleController.text = next;
        }
      },
    );
  }

  @override
  void dispose() {
    _categorytitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = ref.watch(categoryColorProvider);
    final selectedIcon = ref.watch(categoryIconProvider);
    final categoryName = ref.watch(categoryNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            selectedColor != null && selectedIcon != null
                ? Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: selectedColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      selectedIcon,
                      size: 50,
                      color: theme.colorScheme.surface,
                    ),
                  )
                : DottedBorder(
                    options: CircularDottedBorderOptions(
                      dashPattern: [10, 5],
                      strokeWidth: 2,
                      color: theme.colorScheme.primary,
                      padding: EdgeInsets.all(16),
                    ),
                    child: Icon(
                      Icons.dashboard_customize_outlined,
                      size: 50,
                      color: theme.colorScheme.primary,
                    ),
                  ),
            const SizedBox(height: 8),
            Text(" ${categoryName ?? 'Choose Icon'}",
                style: theme.textTheme.titleLarge),
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
                    "Category Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Textfield(
                    controller: _categorytitleController,
                    labelText: "Enter Category Name",
                    onChanged: (value) {
                      ref.read(categoryNameProvider.notifier).state = value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
                margin: const EdgeInsets.all(12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                    Row(
                      children: [
                        const Text("Choose Icon",
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Constant.icons.isNotEmpty
                        ? Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: Constant.icons.map((icon) {
                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(categoryIconProvider.notifier)
                                      .state = icon;
                                },
                                child: Icon(
                                  icon,
                                  size: 28,
                                  color: theme.colorScheme.onSurface,
                                ),
                              );
                            }).toList(),
                          )
                        : const Text("No icons available"),
                  ],
                )),
            const SizedBox(height: 16),
            Container(
                margin: const EdgeInsets.all(12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                    Row(
                      children: [
                        const Text("Choose Color",
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Constant.colors.isNotEmpty
                        ? Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: Constant.colors.map((color) {
                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(categoryColorProvider.notifier)
                                      .state = color;
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.colorScheme.onSurface,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : const Text("No colors available"),
                  ],
                )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Handle add category logic
                  },
                  child: const Text("Add Category"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
