import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Images.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/controller/chatroom_controller.dart';
import 'package:chat_app/controller/profile_controller.dart';
import 'package:chat_app/view/chatroom/widgets/app_bar.dart';
import 'package:chat_app/view/chatroom/widgets/chat_bubble_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:flutter_chat_reactions/utilities/hero_dialog_route.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key});

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  var messageController = TextEditingController();
  RxBool showMic = true.obs;
  RxString remessagevalue = "".obs;
  var chatroomController = Get.put(ChatRoomController());

  String name = "";
  String profile = "";
  String targetUserID = "";
  @override
  void initState() {
    Map<String, dynamic> data = Get.arguments;
    name = data["name"];
    profile = data["profile"] ?? AssetsImage.defaultProfileUrl;
    targetUserID = data["uid"];
    chatroomController.targetUserID = targetUserID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatRoomAppBarView(name: name, profile: profile),
      body: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder(
                        stream: chatroomController.getChats(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Error: ${snapshot.error}"),
                            );
                          } else if (snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("No Messages"),
                            );
                          } else {
                            List<ChatModel> chats = snapshot.data!;

                            return ListView.builder(
                              reverse: true,
                              padding: const EdgeInsets.only(
                                  bottom: 70, top: 20, right: 10, left: 10),
                              itemCount: chats.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onLongPress: () {
                                    Navigator.of(context).push(
                                      HeroDialogRoute(
                                        builder: (context) {
                                          return ReactionsDialogWidget(
                                            id: chats[index]
                                                .id!, // unique id for message
                                            messageWidget: Material(
                                              color: Colors.transparent,
                                              child: ChatBubbleTiel(
                                                chat: chats[index],
                                                isComming:
                                                    chats[index].senderId !=
                                                        loggedInuser,
                                              ),
                                            ), // message widget
                                            onReactionTap: (reaction) {
                                              chatroomController.addEmojis(
                                                  chats[index].id!, reaction);
                                            },
                                            onContextMenuTap: (menuItem) {
                                              if (menuItem.label == "Reply") {
                                                remessagevalue.value =
                                                    chats[index].message ?? "";
                                              } else if (menuItem.label ==
                                                  "Copy") {
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                        chats[index].message ??
                                                            ""));
                                              } else {
                                                chatroomController
                                                    .deleteMessage(
                                                  chats[index].id!,
                                                );
                                              }
                                            },

                                            widgetAlignment:
                                                chats[index].senderId !=
                                                        loggedInuser
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: ChatBubbleTiel(
                                    chat: chats[index],
                                    isComming:
                                        chats[index].senderId != loggedInuser,
                                  ),
                                );
                              },
                            );
                          }
                        }),
                  ],
                ),
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(
        () => Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: remessagevalue.value.isNotEmpty
                  ? BorderRadius.circular(20)
                  : BorderRadius.circular(100),
              color: getColorSchema(context).primaryContainer),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              remessagevalue.value.isNotEmpty
                  ? Row(
                      children: [
                        Expanded(
                            child: Text(
                          remessagevalue.value,
                          style: getTextTheme(context).labelLarge,
                        )),
                        IconButton(
                            onPressed: () {
                              remessagevalue.value = "";
                            },
                            icon: const Icon(Icons.cancel))
                      ],
                    )
                  : const SizedBox(),
              remessagevalue.value.isNotEmpty
                  ? const Divider()
                  : const SizedBox(),
              Row(
                children: [
                  Obx(
                    () => showMic.value
                        ? Row(
                            children: [
                              10.widthBox,
                              SvgPicture.asset(
                                AssetsImage.micSVG,
                                width: 30,
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                  15.widthBox,
                  Expanded(
                      child: TextField(
                    controller: messageController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        showMic.value = true;
                      } else {
                        showMic.value = false;
                      }
                    },
                    decoration: const InputDecoration(
                        filled: false, hintText: "Type message ..."),
                  )),
                  10.widthBox,
                  SvgPicture.asset(
                    AssetsImage.gallerySVG,
                    width: 30,
                  ),
                  10.widthBox,
                  InkWell(
                    onTap: () {
                      if (messageController.text.isNotEmpty) {
                        chatroomController.sendMessage(messageController.text,
                            rereplay: remessagevalue.value);
                        messageController.clear();
                        remessagevalue.value = "";
                      }
                    },
                    child: SvgPicture.asset(
                      AssetsImage.sendSVG,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
