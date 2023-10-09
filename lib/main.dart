import 'package:flutter/material.dart';
import 'package:gisscope/config/app_routes.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:gisscope/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UserProvider(
      userService: UserService(),
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
          fontFamily: 'Urbanist',
          scaffoldBackgroundColor: AppColors.background,
          brightness: Brightness.dark,
        ),
        initialRoute: AppRoutes.login,
        routes: AppRoutes.pages,
      ),
    );
  }
}
