import 'package:chat_app/Config/Images.dart';
import 'package:chat_app/Config/Strings.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

homeappbarView(BuildContext context) => AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          AssetsImage.appIconSVG,
        ),
      ),
      title: Text(
        WelcomePageString.appName,
        style: getTextTheme(context).headlineSmall,
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () {
              Get.toNamed("/profile");
            },
            icon: const Icon(Icons.more_vert)),
      ],
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(60),
      //   child: TabBar(
      //       indicatorWeight: 4,
      //       indicatorSize: TabBarIndicatorSize.label,
      //       labelStyle: getTextTheme(context).bodyLarge,
      //       unselectedLabelStyle: getTextTheme(context).labelLarge,
      //       controller: controller,
      //       tabs: const [
      //         Tab(child: Text("Chats")),
      //         Tab(child: Text("Status"))
      //       ]),
      // ),
    );
