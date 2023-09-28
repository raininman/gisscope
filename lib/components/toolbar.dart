import 'package:flutter/material.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:gisscope/styles/app_text.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final List<Widget>? actions;
  const Toolbar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppText.headerBlack,),
      backgroundColor: AppColors.background,
      actions: actions,
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(73);
}
