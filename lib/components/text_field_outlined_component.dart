import 'package:flutter/material.dart';
import '../resources/color.dart';

class TextFieldOutlinedComponent extends StatelessWidget {
  const TextFieldOutlinedComponent({
    super.key,
    required this.hintText,
    required this.textController,
    required this.keyboardType,
  });

  final String hintText;
  final TextEditingController textController;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: cGray),
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        focusColor: cYellowDark,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: cDarkYellow),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: cDarkYellow),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: cDarkYellow),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
