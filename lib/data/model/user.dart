import 'package:gisscope/data/model/location.dart';

class User {
  final int id;
  final String username;
  final String? firstname;
  final String? lastname;
  final String? mobile;
  final String? birthday;
  final String? gender;
  final bool? visibleGender;
  final Location? location;

  User(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.mobile,
    this.birthday,
    this.gender,
    this.visibleGender,
    this.location,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['id'],
        json['username'],
        json['firstname'],
        json['lastname'],
        json['mobile'],
        json['birthday'],
        json['gender'],
        json['visibleGender'],
        json['location'] != null ? Location.fromJson(json['location']) : null,
      );
}