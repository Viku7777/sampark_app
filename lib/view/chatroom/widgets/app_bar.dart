// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatRoomAppBarView extends StatelessWidget
    implements PreferredSizeWidget {
  String name;
  String profile;
  ChatRoomAppBarView({super.key, required this.name, required this.profile});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              imageUrl: profile,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          10.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: getTextTheme(context).bodyLarge,
              ),
              Text(
                "Online",
                style: getTextTheme(context).labelSmall,
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
        IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
