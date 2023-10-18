import 'package:flutter/material.dart';
import 'package:gisscope/components/app_text_field.dart';
import 'package:gisscope/config/app_routes.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/provider/register_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(children: [
              const Spacer(),
              const Text(
                AppStrings.signUp,
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 95),
              AppTextField(
                hint: AppStrings.username,
                onChange: (value) =>
                    context.read<RegisterProvider>().username = value,
              ),
              const SizedBox(height: 26),
              AppTextField(
                hint: AppStrings.password,
                onChange: (value) =>
                    context.read<RegisterProvider>().password = value,
              ),
              const SizedBox(height: 26),
              AppTextField(
                hint: AppStrings.lastName,
                onChange: (value) =>
                    context.read<RegisterProvider>().lastname = value,
              ),
              const SizedBox(height: 26),
              AppTextField(
                hint: AppStrings.firstName,
                onChange: (value) =>
                    context.read<RegisterProvider>().firstname = value,
              ),
              const SizedBox(height: 95),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RegisterProvider>().register().then((value) {
                      if (value == 'success!') {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.login);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("$value"),
                          ),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.black,
                  ),
                  child: const Text(AppStrings.signUp),
                ),
              ),
              const Spacer(),
            ]),
          ),
        ),
      ),
    );
  }
}
