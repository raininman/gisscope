import 'package:flutter/material.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/styles/app_text.dart';

enum ProfileMenu {
  edit,
  logout,
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: "Profile",
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
                  child: Text("Edit"),
                  value: ProfileMenu.edit,
                ),
                PopupMenuItem(
                  child: Text("Log out"),
                  value: ProfileMenu.logout,
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          UserAvatar(size: 90,),
          SizedBox(
            height: 24,
          ),
          Text(
            "Username",
            style: AppText.subtitle1,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Location",
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
                    "Followers",
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
                    "Posts",
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
                    "Following",
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
