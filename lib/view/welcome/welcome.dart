import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Images.dart';
import 'package:chat_app/Config/Strings.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:chat_app/view/splash/splash_view.dart';
import 'package:chat_app/view/welcome/widget/show_connection.dart';
import 'package:chat_app/view/welcome/widget/welcome_footer_btn.dart';
import 'package:chat_app/view/welcome/widget/welcome_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:velocity_x/velocity_x.dart';

class WelcomeScreenView extends StatelessWidget {
  const WelcomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            30.heightBox,
            const WelcomeHeaderWidget(),
            60.heightBox,
            const ConnectionWidget(),
            30.heightBox,
            Text(
              WelcomePageString.nowYouAre,
              style: getTextTheme(context).headlineMedium,
            ),
            Text(
              WelcomePageString.connected,
              style: getTextTheme(context).headlineLarge,
            ),
            30.heightBox,
            Text(
              WelcomePageString.description,
              style: getTextTheme(context).labelLarge,
              textAlign: TextAlign.center,
            ),
            60.heightBox,
            WelcomeFooterBtn(onSubmit: () => Get.offAllNamed("/authpage")),
            30.heightBox,
          ],
        ),
      )),
    );
  }
}
