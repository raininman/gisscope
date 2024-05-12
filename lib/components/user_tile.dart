import 'package:flutter/material.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:gisscope/styles/app_text.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: AppColors.fieldColor,
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(children: [
          const Icon(Icons.person),
          const SizedBox(width: 10,),
          Text(text,
          style: AppText.body1,),
        ]),
      ),
    );
  }
}
