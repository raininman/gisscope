import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String? baseURL = dotenv.env['API_URL'];
  static String? baseSocketURL = dotenv.env['API_URL_SOCKET'];
}
