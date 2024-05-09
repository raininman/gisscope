import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String? baseURL = dotenv.env['API_URL'];
  static String? geoapifyToken = dotenv.env['GEOAPIFY_TOKEN'];
  static String? tomToken = dotenv.env['TOM_TOKEN'];
  static String? mapBaseURL = 'https://api.geoapify.com';
  static String? mapTomBaseURL = 'https://api.tomtom.com/routing/1/calculateRoute';
  static String? baseSocketURL = dotenv.env['API_URL_SOCKET'];
}
