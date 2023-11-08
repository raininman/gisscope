import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gisscope/config/app_routes.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/location_provider.dart';
import 'package:gisscope/provider/post_provider.dart';
import 'package:gisscope/provider/user_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppRepo>(
          create: (context) => AppRepo(),
        ),
        ChangeNotifierProvider<PostProvider>(
          create: (context) => PostProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<LocationProvider>(
          create: (context) => LocationProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      title: "appName".tr,
      theme: ThemeData(
        fontFamily: Get.deviceLocale == Locale('en', 'US') ? 'Urbanist': 'Onest',
        scaffoldBackgroundColor: AppColors.background,
        brightness: Brightness.dark,
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.pages,
    );
  }
}
