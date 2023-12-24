import 'package:flutter/material.dart';
import '../resources/color.dart';

class TextFieldOutlinedLargeComponent extends StatelessWidget {
  const TextFieldOutlinedLargeComponent({
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
      maxLines: 5,
      controller: textController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        focusColor: cPrimaryGreen,
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
