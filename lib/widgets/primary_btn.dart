import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PrimaryBtn extends StatelessWidget {
  final String name;
  final VoidCallback onclick;
  final IconData icon;
  const PrimaryBtn(
      {super.key,
      required this.name,
      required this.onclick,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getColorSchema(context).primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            10.widthBox,
            Text(
              name,
              style: getTextTheme(context).bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
