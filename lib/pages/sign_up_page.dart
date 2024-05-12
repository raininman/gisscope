import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gisscope/components/app_text_field.dart';
import 'package:gisscope/config/app_routes.dart';
import 'package:gisscope/data/service/auth_service.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/location_provider.dart';
import 'package:gisscope/provider/login_provider.dart';
import 'package:gisscope/provider/register_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  setPrefs(String pushedUsername, String pushedPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', pushedUsername);
    await prefs.setString('password', pushedPassword);
  }

  void register(email, password, context) {
    final _auth = AuthService();
    try {
      _auth.signUpWithEmailPassword(email, password);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _usernameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _passController = TextEditingController();

  final _usernameFocus = FocusNode();
  final _lastnameFocus = FocusNode();
  final _firstnameFocus = FocusNode();
  final _passFocus = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _passController.dispose();
    _passFocus.dispose();
    _usernameFocus.dispose();
    _lastnameFocus.dispose();
    _firstnameFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      "signUp".tr,
                      style: const TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 95),
                    AppTextField(
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(context, _usernameFocus, _passFocus);
                      },
                      focusNode: _usernameFocus,
                      autofocus: true,
                      validate: _validateName,
                      controller: _usernameController,
                      hint: "username".tr,
                    ),
                    const SizedBox(height: 26),
                    AppTextField(
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(context, _passFocus, _lastnameFocus);
                      },
                      focusNode: _passFocus,
                      validate: _validatePassword,
                      controller: _passController,
                      obscureText: _hidePass,
                      hint: "password".tr,
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
                    ),
                    const SizedBox(height: 26),
                    AppTextField(
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(
                            context, _lastnameFocus, _firstnameFocus);
                      },
                      focusNode: _lastnameFocus,
                      validate: _validateName,
                      controller: _lastnameController,
                      hint: "lastName".tr,
                    ),
                    const SizedBox(height: 26),
                    AppTextField(
                      keyboardType: TextInputType.name,
                      focusNode: _firstnameFocus,
                      validate: _validateName,
                      controller: _firstnameController,
                      hint: "firstName".tr,
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      height: 48,
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            final locationProvider =
                              context.read<LocationProvider>();
                          locationProvider.getCurrentPosition();
                          final registerProvider =
                              context.read<RegisterProvider>();
                          registerProvider.lat =
                              locationProvider.currentPosition?.latitude;
                          registerProvider.lng =
                              locationProvider.currentPosition?.longitude;
                          registerProvider.locationName =
                              locationProvider.currentAddress;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.black,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("getLocation".tr),
                              const SizedBox(
                                width: 6,
                              ),
                              const Icon(Icons.location_on_outlined)
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(context.read<LocationProvider>().currentAddress ??
                        'notSpecified'.tr),
                    const SizedBox(height: 95),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _submitForm(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.black,
                        ),
                        child: Text("signUp".tr),
                      ),
                    ),
                    const Spacer(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<RegisterProvider>().password = _passController.text.trim();
      context.read<RegisterProvider>().lastname =
          _lastnameController.text.trim();
      context.read<RegisterProvider>().firstname =
          _firstnameController.text.trim();
      context.read<RegisterProvider>().username =
          _usernameController.text.trim();

      context.read<RegisterProvider>().register().then((value) {
        if (value == 'success!') {
          context.read<LoginProvider>().password = _passController.text.trim();
          context.read<LoginProvider>().username =
              _usernameController.text.trim();
          setPrefs(
              _usernameController.text.trim(), _passController.text.trim());
          register('${_usernameController.text.trim()}@gisscope.com',
              _passController.text.trim(), context);
          context.read<LoginProvider>().login().then((value) {
            context.read<AppRepo>().user = value.user;
            context.read<AppRepo>().token = value.token;
            _showDialog(name: _usernameController.text);
          }).catchError((error) {
            _showMessage(message: '$error');
            return;
          });
        } else {
          _showMessage(message: value);
        }
      }).catchError((error) {
        _showMessage(message: '$error');
      });
    } else {
      _showMessage(message: "invalidForm".tr);
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    final nameExp = RegExp(r'^[А-яЁё A-Za-z]+$');
    if (value == null) {
      return "nameRequired".tr;
    } else if (!nameExp.hasMatch(value)) {
      return "enterAlphabetical".tr;
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (value?.length != 8) {
      return "characterLength".tr;
    } else {
      return null;
    }
  }

  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "registrationSuccessful".tr,
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: Text(
            '$name ${"registered".tr}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                // Navigator.of(context).pushReplacementNamed(AppRoutes.main);
              },
              child: Text(
                "verified".tr,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
