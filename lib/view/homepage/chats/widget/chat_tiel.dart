// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Images.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:chat_app/Model/ChatRoomModel.dart';
import 'package:chat_app/Model/UserModel.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/controller/chatroom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class OldChatTile extends StatefulWidget {
  final String uid;
  final ChatRoomModel chatRoomModel;
  const OldChatTile(
      {super.key, required this.uid, required this.chatRoomModel});

  @override
  State<OldChatTile> createState() => _OldChatTileState();
}

class _OldChatTileState extends State<OldChatTile> {
  UserModel targetUser = UserModel();
  @override
  void initState() {
    userRef.doc(widget.uid).get().then((value) {
      targetUser = UserModel.fromMap(value.data() as Map<String, dynamic>);
      loading.value = false;
    });
    super.initState();
  }

  Rx<bool> loading = true.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() => loading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            onTap: () {
              Get.toNamed("/chatroom", arguments: {
                "name": targetUser.name,
                "profile": targetUser.profileImage,
                "uid": targetUser.id,
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10).copyWith(right: 15),
              margin:
                  const EdgeInsets.symmetric(horizontal: 5).copyWith(top: 5),
              decoration: BoxDecoration(
                  color: getColorSchema(context).primaryContainer,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: targetUser.profileImage ??
                          AssetsImage.defaultProfileUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  15.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        targetUser.name ?? "Not Found",
                        style: getTextTheme(context).bodyLarge,
                      ),
                      5.heightBox,
                      SizedBox(
                        width: 180,
                        child: Text(
                          widget.chatRoomModel.lastMessage.isEmpty
                              ? "Say Hello!!"
                              : widget.chatRoomModel.lastMessage,
                          style: getTextTheme(context).labelMedium!,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    widget.chatRoomModel.time.isNotEmpty
                        ? DateFormat("hh:mm a")
                            .format(DateTime.parse(widget.chatRoomModel.time))
                        : "",
                    style: getTextTheme(context).labelMedium,
                  ),
                ],
              ),
            ),
          ));
  }
}

class ChatTile extends StatelessWidget {
  String name;
  String profile;
  String lastMsg;
  String time;
  String uid;
  ChatTile(
      {super.key,
      required this.name,
      required this.profile,
      required this.lastMsg,
      required this.time,
      required this.uid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.put(ChatRoomController()).createChatroom(
          uid,
        );
        Get.toNamed("/chatroom", arguments: {
          "name": name,
          "profile": profile,
          "uid": uid,
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: getColorSchema(context).primaryContainer,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                profile,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            15.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: getTextTheme(context).bodyLarge,
                ),
                5.heightBox,
                Text(
                  lastMsg,
                  style: getTextTheme(context).labelMedium,
                ),
              ],
            ),
            const Spacer(),
            Text(
              time,
              style: getTextTheme(context).labelMedium,
            )
          ],
        ),
      ),
    );
  }
}
