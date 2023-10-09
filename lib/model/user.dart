import 'dart:convert';

import 'package:gisscope/model/location.dart';

class User {
  final int id;
  final String username;
  final String? firstname;
  final String? lastname;
  final String? mobile;
  final String? birthday;
  final Location? location;
  final String? gender;
  final bool? visibleGender;
  final String? password;
  final String? token;
  final String? avatar;

  User(
      this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.mobile,
      this.birthday,
      this.location,
      this.gender,
      this.visibleGender,
      this.password,
      this.token,
      this.avatar);

  factory User.fromFields(Map<String, dynamic> json) {
    print(json);
    return User(
        json['userId'] as int,
        json['username'] as String,
        json['firstname'] as String?,
        json['lastname'] as String?,
        json['mobile'] as String?,
        json['birthday'] as String?,
        Location.fromJson(jsonDecode((json['location'] as String?) ?? '')
            as Map<String, dynamic>),
        json['gender'] as String?,
        (json['visibleGender'] as int?) == 1,
        json['password'] as String?,
        '',
        json['avatar'] as String?);
  }

    Map<String, dynamic> toJsonLogin() => {
        'id': id,
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'mobile': mobile,
        'birthday': birthday,
        'location': location?.toJson(),
        'gender': gender,
        'visibleGender': visibleGender,
        'token': token,
        'avatar': avatar,
      };
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'mobile': mobile,
        'birthday': birthday,
        'location': location?.toJson(),
        'gender': gender,
        'visibleGender': visibleGender,
        'avatar': avatar,
      };
}
