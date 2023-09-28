import 'package:flutter/material.dart';
import 'package:gisscope/styles/app_text.dart';

class PostItem extends StatelessWidget {
  final String user;
  const PostItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                "assets/temp/user1.jpg",
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                user,
                style: AppText.body1,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Image.asset(
            "assets/temp/post1.png",
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "The sun is a daily reminder that we too can rise from the darkness, that we too can shine our own light 🌞💖",
            style: AppText.body1,
          )
        ],
      ),
    );
  }
}
