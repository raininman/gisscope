import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  const UserAvatar({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      child: Image.asset(
        "assets/temp/user1.jpg",
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
