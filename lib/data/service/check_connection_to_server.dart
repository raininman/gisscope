import 'dart:convert';
import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/data/service/base_service.dart';
import 'package:http/http.dart' as http;

class CheckConnectionToServer extends BaseService{
  @override
  Future<String> call() async {
    final response = await http.post(Uri.parse('${AppConfig.baseURL}/login'),
        body: jsonEncode({
          'username': "user",
          'password': "pass",
        }));
    final json = jsonDecode(response.body);
    final message = json['message'];
    return message;
  }
}
