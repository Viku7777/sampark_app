// ignore_for_file: invalid_use_of_protected_member

import 'package:chat_app/Config/Images.dart';
import 'package:chat_app/Config/Strings.dart';
import 'package:chat_app/Model/UserModel.dart';
import 'package:chat_app/controller/contact_controller.dart';
import 'package:chat_app/controller/profile_controller.dart';
import 'package:chat_app/view/homepage/chats/widget/chat_tiel.dart';
import 'package:chat_app/view/homepage/contacts/widgets/new_contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  bool search = false;
  var controller = Get.put(ContactController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: search
              ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      filled: false,
                      hintText: "Search contact",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              search = false;
                            });
                          },
                          icon: const Icon(Icons.cancel))),
                )
              : const Text("Select contact"),
          actions: search
              ? null
              : [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          search = true;
                        });
                      },
                      icon: const Icon(Icons.search))
                ],
        ),
        body: Obx(
          () => controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    10.heightBox,
                    !search
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NewContactTile(
                                  name: "New Contact",
                                  iconData: Icons.person_add,
                                  onclick: () {}),
                              NewContactTile(
                                  name: "New Group",
                                  iconData: Icons.group_add,
                                  onclick: () {}),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    "Contact on ${WelcomePageString.appName.firstLetterUpperCase()}"),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    ListView.builder(
                      itemCount: controller.users.value.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, index) {
                        List<UserModel> data = controller.users.value.toList();
                        UserModel currentUser = data[index];
                        return currentUser.id == loggedInuser
                            ? const SizedBox()
                            : ChatTile(
                                uid: currentUser.id!,
                                name: currentUser.name ?? "",
                                profile: currentUser.profileImage ??
                                    AssetsImage.defaultProfileUrl,
                                lastMsg: currentUser.about ?? "Hey there",
                                time: "");
                      },
                    )
                  ],
                ),
        ));
  }
}
