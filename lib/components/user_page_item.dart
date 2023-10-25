import 'package:flutter/material.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/data/model/user.dart';
import 'package:gisscope/styles/app_text.dart';

class UserPageItem extends StatelessWidget {
  final User user;
  const UserPageItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Column(children: [
        Row(
          children: [
            UserAvatar(size: 50, path: '${AppConfig.baseURL}${user.avatar}'),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstname} ${user.lastname}',
                  style: AppText.body1Semibold.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  user.visibleGender ?? false ? user.gender ?? '' : '',
                  style: AppText.body1Semibold.copyWith(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        Text(
          user.location?.name ?? '',
          style: AppText.body1.copyWith(color: Colors.black),
        ),
      ]),
    );
  }
}
