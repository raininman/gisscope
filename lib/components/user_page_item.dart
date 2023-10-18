import 'package:flutter/material.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/data/model/user.dart';
import 'package:gisscope/styles/app_text.dart';

class UserPageItem extends StatelessWidget {
  final User user;
  const UserPageItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Column(children: [
        Row(
          children: [
            UserAvatar(size: 50),
            SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstname} ${user.lastname}',
                  style: AppText.body1Semibold.copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  user.location?.name ?? '',
                  style: AppText.body1.copyWith(color: Colors.black),
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
