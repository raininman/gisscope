import 'package:flutter/material.dart';
import 'package:gisscope/components/app_text_field.dart';
import 'package:gisscope/config/app_routes.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/login_provider.dart';
import 'package:gisscope/provider/register_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
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
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _usernameFocus, _passFocus);
                  },
                  focusNode: _usernameFocus,
                  autofocus: true,
                  validate: _validateName,
                  controller: _usernameController,
                  hint: AppStrings.username,
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
                  hint: AppStrings.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _hidePass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 26),
                AppTextField(
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _lastnameFocus, _firstnameFocus);
                  },
                  focusNode: _lastnameFocus,
                  validate: _validateName,
                  controller: _lastnameController,
                  hint: AppStrings.lastName,
                ),
                const SizedBox(height: 26),
                AppTextField(
                  focusNode: _firstnameFocus,
                  validate: _validateName,
                  controller: _firstnameController,
                  hint: AppStrings.firstName,
                ),
                const SizedBox(height: 26),
                SizedBox(
                  height: 48,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      _getCurrentPosition();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.black,
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text("Get Location"), SizedBox(width: 6,), Icon(Icons.location_on_outlined)]),
                  ),
                ),
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
                    child: const Text(AppStrings.signUp),
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

      context.read<RegisterProvider>().lat = _currentPosition!.latitude;
      context.read<RegisterProvider>().lng = _currentPosition!.longitude;
      context.read<RegisterProvider>().locationName = _currentAddress!;

      context.read<RegisterProvider>().register().then((value) {
        if (value == 'success!') {
          context.read<LoginProvider>().password = _passController.text.trim();
          context.read<LoginProvider>().username =
              _usernameController.text.trim();

          context.read<LoginProvider>().login().then((value) {
            context.read<AppRepo>().user = value.user;
            context.read<AppRepo>().token = value.token;
            _showDialog(name: _usernameController.text);
          }).catchError((error) {
            _showMessage(message: '$error');
            return;
          });
          print('Name: ${_usernameController.text}');
        } else {
          _showMessage(message: value);
        }
      }).catchError((error) {
        _showMessage(message: '$error');
      });
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
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
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return 'Name is reqired.';
    } else if (!nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters.';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (value?.length != 8) {
      return '8 character required for password';
    } else {
      return null;
    }
  }

  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Registration successful',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: Text(
            '$name is now a verified register form',
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
                Navigator.of(context).pushReplacementNamed(AppRoutes.main);
              },
              child: const Text(
                'Verified',
                style: TextStyle(
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
