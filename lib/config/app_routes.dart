import 'package:gisscope/pages/edit_profile_page.dart';
import 'package:gisscope/pages/home_page.dart';
import 'package:gisscope/pages/login_page.dart';
import 'package:gisscope/pages/main_page.dart';
import 'package:gisscope/pages/nearby_page.dart';
import 'package:gisscope/pages/profile_page.dart';
import 'package:gisscope/pages/sign_up_page.dart';
import 'package:gisscope/provider/login_provider.dart';
import 'package:gisscope/provider/register_provider.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static final pages = {
    signUp: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (context) => RegisterProvider(),
        ),
      ],
      child: const SignUpPage(),
    ),
    login: (context) => ChangeNotifierProvider(create: (context) => LoginProvider(),
    child: const LoginPage()),
    home: (context) => const HomePage(),
    profile: (context) => const ProfilePage(),
    main: (context) => const MainPage(),
    editProfile: (context) => const EditProfilePage(),
    nearby: (context) => const NearbyPage(),
  };
  static const login = '/';
  static const signUp = '/sign_up';
  static const home = '/home';
  static const profile = '/profile';
  static const main = '/main';
  static const editProfile = '/edit_profile';
  static const nearby = '/nearby';
  static const userPage = '/user_page';

}
