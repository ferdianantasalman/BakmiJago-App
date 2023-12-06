import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';

class MenuProfileComponent extends StatelessWidget {
  const MenuProfileComponent(
      {super.key, required this.icon, required this.name});

  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: cBlack),
            borderRadius: BorderRadius.circular(12),
            color: cWhite),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, color: cDarkGray),
            Text(name, style: bold.copyWith(fontSize: 15, color: cDarkGray)),
            Icon(
              Icons.arrow_forward_ios,
              color: cDarkGray,
            )
          ],
        ),
      ),
    );
  }
}
