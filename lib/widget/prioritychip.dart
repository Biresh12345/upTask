import 'package:flutter/material.dart';

class PriorityChip extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onTap;
  final bool isSelected;

  const PriorityChip({
    super.key,
    required this.title,
    required this.color,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
