import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gisscope/components/app_text_field.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/data/model/location.dart';
import 'package:gisscope/data/model/user.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/location_provider.dart';
import 'package:gisscope/provider/user_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:gisscope/styles/app_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum Gender { none, male, female, other }

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _lastnameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();

  final _lastnameFocus = FocusNode();
  final _firstnameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _birthdayFocus = FocusNode();

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    _phoneFocus.dispose();
    _birthdayFocus.dispose();
    _lastnameFocus.dispose();
    _firstnameFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  var locName;

  var gender = Gender.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const Toolbar(title: AppStrings.editProfile),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Consumer<UserProvider>(
                  builder: (context, value, child) {
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: value.imagePath == null
                              ?  UserAvatar(
                                  size: 120,
                                  path: '${AppConfig.baseURL}${context.read<AppRepo>().user!.avatar}',
                                )
                              : ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  child: SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Image.file(
                                      File(value.imagePath!),
                                    ),
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<UserProvider>()
                                    .pickImage(ImageSource.gallery);
                              },
                              child: const Icon(
                                Icons.photo_camera_outlined,
                                size: 18,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                AppTextField(
                  keyboardType: TextInputType.name,
                  hint: AppStrings.firstName,
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _firstnameFocus, _lastnameFocus);
                  },
                  focusNode: _firstnameFocus,
                  autofocus: true,
                  validate: _validateName,
                  controller: _firstnameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextField(
                  keyboardType: TextInputType.name,
                  hint: AppStrings.lastName,
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _lastnameFocus, _phoneFocus);
                  },
                  focusNode: _lastnameFocus,
                  validate: _validateName,
                  controller: _lastnameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextField(
                  keyboardType: TextInputType.phone,
                  hint: AppStrings.phoneNumber,
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _phoneFocus, _birthdayFocus);
                  },
                  focusNode: _phoneFocus,
                  controller: _phoneController,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 48,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final locationProvider =
                            context.read<LocationProvider>();
                        locationProvider.getCurrentPosition();
                        final userProvider = context.read<UserProvider>();
                        userProvider.lat =
                            locationProvider.currentPosition?.latitude;
                        userProvider.lng =
                            locationProvider.currentPosition?.longitude;
                        userProvider.locationName =
                            locationProvider.currentAddress;
                        locName = locationProvider.currentAddress;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.black,
                    ),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Get Location"),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(Icons.location_on_outlined)
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(context.read<LocationProvider>().error ??
                    locName ??
                    'Not specified'),
                const SizedBox(
                  height: 16,
                ),
                AppTextField(
                  keyboardType: TextInputType.datetime,
                  hint: AppStrings.birthday,
                  focusNode: _birthdayFocus,
                  controller: _birthdayController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  decoration: BoxDecoration(
                    color: AppColors.fieldColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.gender,
                        style: AppText.body2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                title: const Text(AppStrings.male),
                                value: Gender.male,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = Gender.male;
                                  });
                                }),
                          ),
                          Expanded(
                            child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                title: const Text(AppStrings.female),
                                value: Gender.female,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = Gender.female;
                                  });
                                }),
                          ),
                          Expanded(
                            child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                title: const Text(AppStrings.other),
                                value: Gender.other,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = Gender.other;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 48,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      final provider = context.read<UserProvider>();
                      User? currUser = context.read<AppRepo>().user;
                      provider.birthday = _birthdayController.text;
                      provider.lastname = _lastnameController.text;
                      provider.firstname = _firstnameController.text;
                      provider.phoneNumber = _phoneController.text;
                      provider.token = context.read<AppRepo>().token!;
                      String? parsedGender;
                      switch (gender) {
                        case Gender.male:
                          {
                            parsedGender = 'male';
                            break;
                          }
                        case Gender.female:
                          {
                            parsedGender = 'female';
                            break;
                          }
                        case Gender.other:
                          {
                            parsedGender = 'other';
                            break;
                          }
                        case Gender.none:
                          {
                            parsedGender = '';
                            break;
                          }
                      }
                      provider.gender = parsedGender;

                      final locationProvider = context.read<LocationProvider>();
                      List<String> mylist = provider.imagePath.split('/');
                      final last = mylist[mylist.length-1];
                      final fullPath = '/images/${last}';

                      provider.updateUser().then((response) {
                        if (response == 'success!') {
                          final newUser = User(
                              currUser!.id,
                              currUser!.username,
                              _firstnameController.text,
                              _lastnameController.text,
                              _phoneController.text,
                              _birthdayController.text,
                              parsedGender,
                              false,
                              Location(
                                  locationProvider.currentPosition!.latitude,
                                  locationProvider.currentPosition!.longitude,
                                  locationProvider.currentAddress!),
                              fullPath);
                          currUser = newUser;
                          print(fullPath);

                          Navigator.of(context).pop();
                        } else {
                          print(response);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.black,
                    ),
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
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
}
