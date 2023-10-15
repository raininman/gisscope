import 'package:flutter/material.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/data/model/chat.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:gisscope/styles/app_text.dart';

class ChatOtherItem extends StatelessWidget {
  final Chat chat;
  const ChatOtherItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 16,
        right: 30,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${chat.user.firstname} ${chat.user.lastname}",
                        style: AppText.body1Semibold.copyWith(color: AppColors.fontColor2)),
                        SizedBox(height: 6,),
                    Text(
                      chat.message,
                      style: AppText.body1.copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
