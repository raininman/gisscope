import 'package:flutter/material.dart';
import 'package:gisscope/components/post_item.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/post_provider.dart';
import 'package:gisscope/styles/app_text.dart';
import 'package:provider/provider.dart';

enum ProfileMenu {
  edit,
  logout,
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppRepo>(context).user;
    return Scaffold(
      appBar: Toolbar(
        title: AppStrings.profile,
        actions: [
          PopupMenuButton<ProfileMenu>(
            onSelected: (value) {
              switch (value) {
                case ProfileMenu.logout:
                  print("logout");
                  break;
                case ProfileMenu.edit:
                  Navigator.of(context).pushNamed("/edit_profile");
                  break;
                default:
                  print("Error");
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: ProfileMenu.edit,
                  child: Text(AppStrings.edit),
                ),
                const PopupMenuItem(
                  value: ProfileMenu.logout,
                  child: Text(AppStrings.logOut),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            UserAvatar(
              size: 90,
              path: '${AppConfig.baseURL}${user?.avatar}'
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "${user?.username}",
              style: AppText.subtitle1,
            ),
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "${user?.location?.name}",
                style: AppText.subtitle1.copyWith(),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 12,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Consumer<PostProvider>(
                builder: (context, value, child) {
                  final posts = value.getPostsByUserId(user!.id);
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return PostItem(post: posts[index], tapCheck: false,);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 24);
                    },
                    itemCount: posts.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
