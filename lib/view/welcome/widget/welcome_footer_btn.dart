import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Images.dart';
import 'package:chat_app/Config/Strings.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeFooterBtn extends StatelessWidget {
  final Future<dynamic>? Function()? onSubmit;
  const WelcomeFooterBtn({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      sliderRotate: true,
      onSubmit: onSubmit,
      sliderButtonIcon: SvgPicture.asset(
        AssetsImage.plugSVG,
        width: 25,
      ),
      submittedIcon: SvgPicture.asset(
        AssetsImage.connectSVG,
        width: 25,
      ),
      text: WelcomePageString.slideToStart,
      textStyle: getTextTheme(context).labelLarge,
      innerColor: getColorSchema(context).primary,
      outerColor: getColorSchema(context).primaryContainer,
      // animationDuration: const Duration(seconds: 1),
    );
  }
}
