import 'dart:convert';

import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/data/response/login_response.dart';
import 'package:gisscope/data/service/base_service.dart';
import 'package:http/http.dart' as http;

class LoginService extends BaseService{
  final String username;
  final String password;

  LoginService(this.username, this.password);
  @override
  Future<LoginResponse> call() async {
    final result = await http.post(Uri.parse('${AppConfig.baseURL}/login'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }));
    return LoginResponse.fromJson(jsonDecode(result.body)['data']);
  }
}
