import 'package:flutter/material.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/data/model/chat.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:gisscope/styles/app_text.dart';

class ChatMeItem extends StatelessWidget {
  final Chat chat;
  const ChatMeItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top:8,
        left: 30,
        right: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Text(
                  chat.message,
                  style: AppText.body1.copyWith(color: AppColors.black),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          UserAvatar(),
        ],
      ),
    );
  }
}
