import 'package:flutter/material.dart';
import 'package:gisscope/data/service/register_service.dart';

class RegisterProvider extends ChangeNotifier {
  var username;
  var password;
  var firstname;
  var lastname;
  var location = Map<String, dynamic>.from({"name": "Minsk", "lat": 0.0, "lng": 0.0});

  Future<String> register() async {
    return RegisterService(
            this.username, this.password, this.lastname, this.firstname, this.location)
        .call();
  }
}
