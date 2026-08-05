import 'package:flutter/material.dart';

class Drawerlabel extends StatelessWidget {
  final String? label;
  final VoidCallback? onTap;
  final IconData? icon;
  const Drawerlabel(
      {super.key, required this.label, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              label!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
