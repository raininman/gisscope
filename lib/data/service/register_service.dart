import 'dart:convert';

import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/data/service/base_service.dart';
import 'package:http/http.dart' as http;

class RegisterService extends BaseService{
  final String username;
  final String password;
  final String  firstname;
  final String  lastname;
  final Map<String, dynamic>  location;


  RegisterService(this.username, this.password, this.firstname, this.lastname, this.location);
  @override
  Future<String> call() async {
    final result = await http.post(Uri.parse('${AppConfig.baseURL}/signup'),
        body: jsonEncode({
          'username': username,
          'password': password,
          'lastname': lastname,
          'firstname': firstname,
          'location':location
        }));
    return jsonDecode(result.body)['message'];
  }
}
