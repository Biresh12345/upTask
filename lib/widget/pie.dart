import 'package:flutter/material.dart';

class Pie extends StatelessWidget {
  final String title;
  const Pie({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(100)),
        height: 200,
        width: 200);
  }
}
