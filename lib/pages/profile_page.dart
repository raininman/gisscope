import 'package:flutter/material.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/provider/app_repo.dart';
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
                PopupMenuItem(
                  child: Text(AppStrings.edit),
                  value: ProfileMenu.edit,
                ),
                PopupMenuItem(
                  child: Text(AppStrings.logOut),
                  value: ProfileMenu.logout,
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          UserAvatar(
            size: 90,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "${user?.username}",
            style: AppText.subtitle1,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "${user?.location?.name}",
            style: AppText.subtitle1,
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "123",
                    style: AppText.subtitle1,
                  ),
                  Text(
                    AppStrings.followers,
                    style: AppText.body1,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "123",
                    style: AppText.subtitle1,
                  ),
                  Text(
                    AppStrings.posts,
                    style: AppText.body1,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "123",
                    style: AppText.subtitle1,
                  ),
                  Text(
                    AppStrings.following,
                    style: AppText.body1,
                  )
                ],
              ),
            ],
          ),
          Divider(
            thickness: 1,
            height: 12,
          )
        ],
      ),
    );
  }
}
