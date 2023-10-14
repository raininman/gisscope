import 'dart:convert';
import 'package:gisscope/config/app_config.dart';
import 'package:http/http.dart' as http;

class CheckConnectionToServer {
  @override
  Future<String> call() async {
    final response = await http.get(Uri.parse('${AppConfig.baseURL}/'));
    final json = jsonDecode(response.body);
    final message = json['message'];
    return message;
  }
}
