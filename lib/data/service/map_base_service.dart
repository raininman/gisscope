import 'dart:convert';

import 'package:gisscope/config/app_config.dart';
import 'package:http/http.dart' as http;

abstract class MapBaseService<T> {
  Future<T> call();
  final token = AppConfig.geoapifyToken;
  final tomToken = AppConfig.tomToken;

  Uri _getV1Url(String url) =>
      Uri.parse("${AppConfig.mapBaseURL}/$url&apiKey=$token");

  Uri _getV2Url(String url) =>
      Uri.parse("${AppConfig.mapTomBaseURL}/$url&key=$tomToken");

  Future<Map<String, dynamic>> get(String apiUrl) async {
    try {
      print(_getV1Url(apiUrl));

      return _handleResponse(await MyRequest().get(_getV1Url(apiUrl)));
    } catch (e) {
      throw Exception(e);
    }
  }

    Future<Map<String, dynamic>> tomGet(String apiUrl) async {
    try {
      print(_getV2Url(apiUrl));

      return _handleResponse(await MyRequest().get(_getV2Url(apiUrl)));
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

class MyRequest extends http.BaseClient {
  final String? token;

  MyRequest([this.token]);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return request.send();
  }
}
