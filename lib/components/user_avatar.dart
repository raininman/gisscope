import 'package:flutter/material.dart';
import 'package:gisscope/config/app_config.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final String? path;
  const UserAvatar({super.key, this.size = 40, this.path});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: path != null || path == AppConfig.baseURL
          ? Image.network("$path", width: size, height: size, fit: BoxFit.cover,
              errorBuilder: (context, exception, stackTrace) {
              return Image.asset(
                "assets/temp/user1.jpg",
                width: size,
                height: size,
                fit: BoxFit.cover,
              );
            })
          : Image.asset(
              "assets/temp/user1.jpg",
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
    );
  }
}
