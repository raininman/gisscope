import 'package:flutter/material.dart';
import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/data/model/post.dart';
import 'package:gisscope/pages/user_page.dart';
import 'package:gisscope/styles/app_text.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final user = post.owner!;
        Route route = MaterialPageRoute(
            builder: (context) => UserPage(
                  user: user,
                ));
        Navigator.push(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/temp/user1.jpg",
                  width: 40,
                  height: 40,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "${post.owner?.firstname} ${post.owner?.lastname}",
                  style: AppText.body1,
                ),
              ],
            ),
            if (post.image != null) ...[
              const SizedBox(
                height: 12,
              ),
              Image.network(
                "${AppConfig.baseURL}${post.image}",
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(
                    "assets/temp/post1.png",
                  );
                },
              ),
            ],
            const SizedBox(
              height: 12,
            ),
            Text(
              post.message ?? '',
              style: AppText.body1,
            )
          ],
        ),
      ),
    );
  }
}
