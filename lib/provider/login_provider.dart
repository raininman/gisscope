import 'package:flutter/material.dart';
import 'package:gisscope/data/response/login_response.dart';
import 'package:gisscope/data/service/check_connection_to_server.dart';
import 'package:gisscope/data/service/login_service.dart';

class LoginProvider extends ChangeNotifier {
  var username;
  var password;

  Future<String> checkConnection() async {
    final response = await CheckConnectionToServer().call();
    return response;
  }

  Future<LoginResponse> login() async {
    return LoginService(this.username, this.password).call();
  }
}
