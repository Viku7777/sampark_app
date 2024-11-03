import 'package:chat_app/controller/notification_controller.dart';
import 'package:chat_app/view/homepage/chats/widget/app_bar_view.dart';
import 'package:chat_app/view/homepage/chats/widget/chatlist.dart';
import 'package:chat_app/view/homepage/chats/widget/floating_btn.dart';
import 'package:flutter/material.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeappbarView(context),
      body: const ChatList(),
      floatingActionButton: FloatingBtn(onclick: () async {
        NoificationRepository.sendNotification(
            "",
            "this is check notification",
            {},
            "cvvFgbRQRruyTevrUQ-VyM:APA91bFz3uNPFPWI_MkreV7EfV8ii6OOkpbVL9FcEdW8-znEajMth68Pk1arbHrL-xsd2skumA15MAvDQLsxZd4PFJI9xuLQpFcZGuIPgayLvO8sVgw0ZXA");
        // Get.toNamed("/contact");
      }),
    );
  }
}
