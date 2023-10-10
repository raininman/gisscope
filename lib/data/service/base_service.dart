import 'dart:convert';

import 'package:gisscope/config/app_config.dart';
import 'package:http/http.dart' as http;

abstract class BaseService<T> {
  Future<T> call();

  Uri _getV1Url(String url) => Uri.parse("${AppConfig.baseURL}/$url");

  Future<Map<String, dynamic>> get(String apiUrl) async {
    try {
      return _handleResponse(await http.get(_getV1Url(apiUrl)));
    } catch (e) {
      throw Exception(e);
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception();
    }
  }
}
