import 'package:chat_app/Config/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConnectionWidget extends StatelessWidget {
  const ConnectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetsImage.boyPic),
        SvgPicture.asset(AssetsImage.connectSVG),
        Image.asset(AssetsImage.girlPic),
      ],
    );
  }
}
