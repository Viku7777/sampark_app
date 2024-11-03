import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class NewContactTile extends StatelessWidget {
  final VoidCallback onclick;
  final String name;
  final IconData iconData;
  const NewContactTile(
      {super.key,
      required this.name,
      required this.iconData,
      required this.onclick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
        margin: const EdgeInsets.all(10).copyWith(top: 0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: getColorSchema(context).primaryContainer,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: getColorSchema(context).primary,
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                iconData,
                size: 30,
              ),
            ),
            20.widthBox,
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
