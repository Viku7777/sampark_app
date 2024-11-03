// ignore_for_file: must_be_immutable

import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/widgets/stacked_reactions.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatBubbleTiel extends StatelessWidget {
  ChatModel chat;
  bool isComming;
  ChatBubbleTiel({super.key, required this.chat, required this.isComming});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isComming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          constraints: BoxConstraints(
            minWidth: 50,
            maxWidth: MediaQuery.of(context).size.width / 1.3,
          ),
          decoration: BoxDecoration(
              color: getColorSchema(context).primaryContainer,
              borderRadius: BorderRadius.circular(10).copyWith(
                  bottomLeft: Radius.circular(isComming ? 0 : 10),
                  bottomRight: Radius.circular(isComming ? 10 : 0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chat.imageUrl.isNotEmptyAndNotNull
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(chat.imageUrl!)),
                    )
                  : const SizedBox(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  chat.replies.isNotEmptyAndNotNull
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "RE : ${chat.replies!}",
                              style: getTextTheme(context).labelLarge,
                            ),
                            10.heightBox,
                          ],
                        )
                      : const SizedBox(),
                  Text(chat.message ?? ""),
                ],
              ),
            ],
          ),
        ),
        10.heightBox,
        Row(
          mainAxisAlignment:
              isComming ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  DateFormat("hh:mm a").format(DateTime.parse(chat.timestamp!)),
                  style: getTextTheme(context).labelMedium,
                ),
                chat.reaction.isNotEmptyAndNotNull ? 20.widthBox : 10.widthBox,
                chat.reaction.isNotEmptyAndNotNull
                    ? StackedReactions(
                        // reactions widget
                        size: 15,

                        reactions: [chat.reaction!], // list of reaction strings
                        stackedValue:
                            4.0, // Value used to calculate the horizontal offset of each reaction
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
        20.heightBox,
      ],
    );
  }
}
