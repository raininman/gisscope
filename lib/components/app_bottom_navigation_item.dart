import 'package:flutter/material.dart';
import 'package:gisscope/pages/main_page.dart';
import 'package:gisscope/styles/app_colors.dart';

class AppBottomNavigationBarItem extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Menus current;
  final Menus name;
  const AppBottomNavigationBarItem(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.current,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 24,
        color: (current == name)
            ? AppColors.black
            : AppColors.black.withOpacity(0.3),
      ),
    );
  }
}
