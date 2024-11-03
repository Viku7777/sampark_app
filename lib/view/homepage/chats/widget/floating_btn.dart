import 'package:chat_app/Config/Colors.dart';
import 'package:flutter/material.dart';

class FloatingBtn extends StatelessWidget {
  final VoidCallback onclick;
  const FloatingBtn({
    super.key,
    required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onclick,
      backgroundColor: getColorSchema(context).primary,
      child: Icon(
        Icons.add,
        color: getColorSchema(context).onBackground,
      ),
    );
  }
}
