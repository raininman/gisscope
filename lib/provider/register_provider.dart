import 'package:flutter/material.dart';
import 'package:gisscope/data/service/register_service.dart';

class RegisterProvider extends ChangeNotifier {
  var username;
  var password;
  var firstname;
  var lastname;
  var lat;
  var lng;
  var locationName;

  Future<String> register() async {
    return RegisterService(username, password, lastname,
            firstname, toJson())
        .call();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['name'] = locationName;
    return data;
  }
}
