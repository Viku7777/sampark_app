import 'dart:async';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/controller/profile_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ChatRoomController extends GetxController {
  RxBool loading = false.obs;
  String targetUserID = "";
  bool isloggedInuser1 = false;

  RxList<ChatModel> userchats = <ChatModel>[].obs;
  String getRoomID(String targetUserID) {
    if (loggedInuser.hashCode > targetUserID.hashCode) {
      return loggedInuser + targetUserID;
    } else {
      return targetUserID + loggedInuser;
    }
  }

  Stream<List<ChatModel>> getChats() {
    String chatroomId = getRoomID(targetUserID);
    return chatRefdb
        .child("/$chatroomId/messages")
        .orderByChild(
          "timestamp",
        )
        .onValue
        .map((event) => event.snapshot.children
            .toList()
            .reversed
            .map((e) => ChatModel.fromJson(e.value as Map<Object?, Object?>))
            .toList());
  }

  Future<void> createChatroom(String targetUser) async {
    targetUserID = targetUser;
    String chatroomId = getRoomID(targetUser);
    var chatroomDetails = await chatroom.doc(chatroomId).get();
    if (!chatroomDetails.exists) {
      isloggedInuser1 = true;
      await chatroom.doc(chatroomId).set({
        "users": [loggedInuser, targetUserID],
        "lastMessage": "",
        "time": DateTime.now().toIso8601String(),
      });
    }
  }

  Future<void> sendMessage(String message, {String rereplay = ""}) async {
    String chatroomId = getRoomID(targetUserID);
    ChatModel chat = ChatModel(
      id: const Uuid().v4(),
      message: message,
      senderId: loggedInuser,
      replies: rereplay,
      timestamp: DateTime.now().toIso8601String(),
    );
    try {
      await chatRefdb
          .child("$chatroomId/messages/${chat.id}")
          .set(chat.toJson());
      await chatroom.doc(chatroomId).update({
        "lastMessage": message,
        "time": DateTime.now().toIso8601String(),
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> deleteMessage(String id) async {
    String chatroomId = getRoomID(targetUserID);
    await chatRefdb.child("$chatroomId/messages/$id").remove();
  }

  Future<void> addEmojis(String id, String reaction) async {
    String chatroomId = getRoomID(targetUserID);
    await chatRefdb.child("$chatroomId/messages/$id").update({
      "reaction": reaction,
    });
  }

  Future<void> cleanAllChats(String roomId) async {
    String chatroomId = getRoomID(roomId);
    await chatroom.doc(chatroomId).delete();
    await chatRefdb.child(chatroomId).remove();
  }
}
