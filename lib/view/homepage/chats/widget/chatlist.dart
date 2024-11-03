import 'package:chat_app/Model/ChatRoomModel.dart';
import 'package:chat_app/controller/chatroom_controller.dart';
import 'package:chat_app/controller/profile_controller.dart';
import 'package:chat_app/view/homepage/chats/widget/chat_tiel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chatroom")
            .where("users", arrayContainsAny: [loggedInuser]).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Messages"),
            );
          } else {
            List<ChatRoomModel> chatrooms = snapshot.data!.docs
                .map((e) => ChatRoomModel.fromMap(e.data()))
                .toList();
            chatrooms.sort((a, b) => b.time.compareTo(a.time));
            return ListView.builder(
                itemCount: chatrooms.length,
                itemBuilder: (context, index) {
                  ChatRoomModel chatroom = chatrooms[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Get.put(ChatRoomController()).cleanAllChats(
                                chatroom.users[0] == loggedInuser
                                    ? chatroom.users[1]
                                    : chatroom.users[0]);
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: OldChatTile(
                        chatRoomModel: chatroom,
                        uid: chatroom.users[0] == loggedInuser
                            ? chatroom.users[1]
                            : chatroom.users[0]),
                  );
                });
          }
        });
  }
}
