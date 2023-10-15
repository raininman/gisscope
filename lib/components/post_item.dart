import 'package:flutter/material.dart';
import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/data/model/post.dart';
import 'package:gisscope/styles/app_text.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({super.key, required this.post});

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
                "${post.owner?.firstname} ${post.owner?.lastname}",
                style: AppText.body1,
              ),
            ],
          ),
          if (post.image != null) ...[
            SizedBox(
              height: 12,
            ),
            Image.network(
              "${AppConfig.baseURL}/${post.image}",
              errorBuilder: (context, exception, stackTrace) {
                return Image.asset(
                  "assets/temp/post1.png",
                );
              },
            ),
          ],
          SizedBox(
            height: 12,
          ),
          Text(
            post.message ?? '',
            style: AppText.body1,
          )
        ],
      ),
    );
  }
}
