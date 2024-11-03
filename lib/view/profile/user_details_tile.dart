import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Images.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:chat_app/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getColorSchema(context).primaryContainer),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.currentUser.value.profileImage.isNotEmptyAndNotNull
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.network(
                    controller.currentUser.value.profileImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(AssetsImage.boyPic),
          20.heightBox,
          Obx(
            () => Text(
              controller.currentUser.value.name ?? "Please Wait",
              style: getTextTheme(context).bodyLarge,
            ),
          ),
          Obx(
            () => Text(
              controller.currentUser.value.email ?? "",
              style: getTextTheme(context).labelLarge,
            ),
          ),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              {
                "title": "Call",
                "color": const Color(0xff039C00),
                "icon": AssetsImage.profileAudioCall,
              },
              {
                "title": "Video",
                "color": const Color(0xffFF9900),
                "icon": AssetsImage.profileVideoCall,
              },
              {
                "title": "Chat",
                "color": const Color(0xff0057FF),
                "icon": AssetsImage.appIconSVG,
              },
            ]
                .map((e) => Container(
                      height: 50,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: getColorSchema(context).background),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            e["icon"] as String,
                            height: 25,
                            color: e["color"] as Color,
                          ),
                          10.widthBox,
                          Text(
                            e["title"] as String,
                            style: TextStyle(
                              color: e["color"] as Color,
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
