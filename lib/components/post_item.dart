import 'package:flutter/material.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/data/model/post.dart';
import 'package:gisscope/pages/user_page.dart';
import 'package:gisscope/styles/app_text.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final bool? tapCheck;
  const PostItem({super.key, required this.post, this.tapCheck});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tapCheck == null) {
          final user = post.owner!;
          Route route = MaterialPageRoute(
              builder: (context) => UserPage(
                    user: user,
                  ));
          Navigator.push(context, route);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                UserAvatar(size: 40, path: '${AppConfig.baseURL}${post.owner?.avatar}',),
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
