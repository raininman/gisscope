import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gisscope/config/app_routes.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/login_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameFocus = FocusNode();
  final _passFocus = FocusNode();

  @override
  void dispose() {
    _passFocus.dispose();
    _usernameFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool _hidePass = true;

  setPrefs(String pushedUsername, String pushedPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', pushedUsername);
    await prefs.setString('password', pushedPassword);
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
        Navigator.of(context).pushReplacementNamed(AppRoutes.main);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPrefs(context),
        builder: (context, snapshot) {
          return snapshot.data ?? false
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const Spacer(),
                          Text(
                            "helloWelcome".tr,
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "loginToContinue".tr,
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          TextFormField(
                            onFieldSubmitted: (_) {
                              _fieldFocusChange(
                                  context, _usernameFocus, _passFocus);
                            },
                            focusNode: _usernameFocus,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: "username".tr,
                              labelText: "username".tr,
                              labelStyle:
                                  const TextStyle(color: AppColors.white),
                              border: const UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.fieldColor,
                            ),
                            onChanged: (value) {
                              context.read<LoginProvider>().username =
                                  value.trim();
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextField(
                            obscureText: _hidePass,
                            focusNode: _passFocus,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(_hidePass
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _hidePass = !_hidePass;
                                  });
                                },
                              ),
                              hintText: "password".tr,
                              labelText: "password".tr,
                              labelStyle:
                                  const TextStyle(color: AppColors.white),
                              border: const UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.fieldColor,
                            ),
                            onChanged: (value) {
                              context.read<LoginProvider>().password =
                                  value.trim();
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                print("Forgot");
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.fontColor,
                              ),
                              child: Text("forgotPassword".tr),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<LoginProvider>()
                                    .login()
                                    .then((value) {
                                  context.read<AppRepo>().user = value.user;
                                  context.read<AppRepo>().token = value.token;
                                  setPrefs(
                                      context.read<LoginProvider>().username,
                                      context.read<LoginProvider>().password);
                                  Navigator.of(context)
                                      .pushReplacementNamed(AppRoutes.main);
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("userNotFound".tr),
                                    ),
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.black,
                              ),
                              child: Text("login".tr),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "orSignIn".tr,
                            style: const TextStyle(
                                color: AppColors.fontColor, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 24.5,
                          ),
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print("google");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/google.png",
                                    width: 22,
                                    height: 22,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text("loginGoogle".tr)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print("facebook");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/facebook.png",
                                    width: 22,
                                    height: 22,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text("loginFacebook".tr)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "dontHaveAccount".tr,
                                style: const TextStyle(
                                  color: AppColors.disableFont,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primary),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.signUp);
                                },
                                child: Text(
                                  "signUp".tr,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
