import 'package:flutter/material.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/login_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  AppStrings.helloWelcome,
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  AppStrings.loginToContinue,
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: AppStrings.username,
                    labelText: AppStrings.username,
                    labelStyle: const TextStyle(color: AppColors.white),
                    border: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.fieldColor,
                  ),
                  onChanged: (value) {
                    context.read<LoginProvider>().username = value;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: AppStrings.password,
                    labelText: AppStrings.password,
                    labelStyle: const TextStyle(color: AppColors.white),
                    border: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.fieldColor,
                  ),
                  onChanged: (value) {
                    context.read<LoginProvider>().password = value;
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
                    child: const Text(AppStrings.forgotPassword),
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
                      context.read<LoginProvider>().login().then((value) {
                        context.read<AppRepo>().user = value.user;
                        context.read<AppRepo>().token = value.token;
                        Navigator.of(context).pushReplacementNamed('/main');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.black,
                    ),
                    child: const Text(AppStrings.login),
                  ),
                ),
                const Spacer(),
                const Text(
                  AppStrings.orSignIn,
                  style: TextStyle(color: AppColors.fontColor, fontSize: 16),
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
                        const Text(AppStrings.loginGoogle)
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
                        const Text(AppStrings.loginFacebook)
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
                    const Text(
                      AppStrings.dontHaveAccount,
                      style: TextStyle(
                        color: AppColors.disableFont,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary),
                      onPressed: () {
                        print("sign up");
                      },
                      child: const Text(
                        AppStrings.signUp,
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
