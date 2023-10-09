import 'package:flutter/material.dart';
import 'package:gisscope/data/response/login_response.dart';
import 'package:gisscope/data/service/login_service.dart';

class LoginProvider extends ChangeNotifier {
  var username;
  var password;

  Future<LoginResponse> login() async {
    return LoginService(this.username, this.password).call();
  }
}
