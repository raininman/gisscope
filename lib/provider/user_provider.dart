import 'package:flutter/material.dart';
import 'package:gisscope/data/model/user.dart';
import 'package:gisscope/data/service/get_all_users_service.dart';
import 'package:gisscope/data/service/update_user_service.dart';
import 'package:gisscope/data/service/upload_service.dart';
import 'package:gisscope/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  var lastname;
  var firstname;
  var phoneNumber;
  var lat;
  var lng;
  var locationName;
  var birthday;
  var gender;
  var visibleGender;
  var token;
  var imagePath;

  Future<List<User>> getAllUsers() async {
    return await GetAllUsersService().call();
  }

  Future<String> updateUser() async {
    String? image;
    if (imagePath != null) {
      image = await upload();
    }
    return await UpdateUserService(
      lastname: lastname,
      firstname: firstname,
      phoneNumber: phoneNumber,
      location: mapLocation(),
      birthday: birthday,
      gender: gender,
      token: token,
      image: image,
      visibleGender: visibleGender,
    ).call();
  }

  Future<String> upload() async {
    return await UploadService(imagePath!).call();
  }

  pickImage(ImageSource source) async {
    try {
      final path = await Utils.pickImage(source);
      final croppedImage = await Utils.cropImage(path);
      imagePath = croppedImage?.path ?? '';
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Map<String, dynamic> mapLocation() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['name'] = locationName;
    return data;
  }
}
