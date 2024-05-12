import 'package:flutter/material.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:gisscope/styles/app_text.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    if (isCurrentUser) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 8,
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
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Text(
                    message,
                    style: AppText.body1.copyWith(color: AppColors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      );
    }else{
      return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 16,
        right: 30,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
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
}
