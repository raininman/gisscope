import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gisscope/config/app_routes.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/firebase_options.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/location_provider.dart';
import 'package:gisscope/provider/login_provider.dart';
import 'package:gisscope/provider/map_provider.dart';
import 'package:gisscope/provider/post_provider.dart';
import 'package:gisscope/provider/user_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider<MapProvider>(
          create: (context) => MapProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

  Future<bool> getPrefs(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    final String? password = prefs.getString('password');
    print(password);
    print(username);

    if (username != null && password != null) {
      context.read<LoginProvider>().password = password;
      context.read<LoginProvider>().username = username;
      context.read<LoginProvider>().login().then((value) {
        context.read<AppRepo>().user = value.user;
        context.read<AppRepo>().token = value.token;
        return true;
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("userNotFound".tr),
          ),
        );
        return false;
      });
    }
    return false;
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPrefs(context),
      builder:(context, snapshot)=> GetMaterialApp(
        translations: Languages(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        title: "appName".tr,
        theme: ThemeData(
          fontFamily:
              Get.deviceLocale == Locale('en', 'US') ? 'Urbanist' : 'Onest',
          scaffoldBackgroundColor: AppColors.background,
          brightness: Brightness.dark,
        ),
        initialRoute: AppRoutes.authGate,
        routes: AppRoutes.pages,
      ),
    );
  }
}
