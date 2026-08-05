import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? icon;
  final IconData? suffixIcon;
  final ValueChanged<String?>? onChanged;
  final Color? fillcolor;
  final bool? filled;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  const Textfield(
      {super.key,
      required this.labelText,
      this.icon,
      this.suffixIcon,
      this.controller,
      this.onChanged,
      this.fillcolor,
      this.filled = false,
      this.disabledBorder,
      this.enabledBorder,
      this.focusedBorder,
      this.errorBorder,
      this.focusedErrorBorder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: enabledBorder ?? InputBorder.none,
        focusedBorder: focusedBorder ?? InputBorder.none,
        disabledBorder: disabledBorder ?? InputBorder.none,
        errorBorder: errorBorder ?? InputBorder.none,
        focusedErrorBorder: focusedErrorBorder ?? InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: filled,
        fillColor: fillcolor,
        contentPadding: EdgeInsets.symmetric(horizontal: 4),
        border: OutlineInputBorder(),
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
    );
  }
}
