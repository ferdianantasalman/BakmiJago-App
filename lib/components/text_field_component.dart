import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {super.key,
      required this.controller,
      this.validator,
      required this.hintText,
      this.icon,
      required this.obsecureText,
      required this.keyboarType});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final IconData? icon;
  final bool obsecureText;
  final TextInputType keyboarType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboarType,
      validator: validator,
      obscureText: obsecureText,
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
        fillColor: Colors.black.withOpacity(0.04),
        prefixIcon: Icon(
          icon,
          color: Colors.black.withOpacity(0.25),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
