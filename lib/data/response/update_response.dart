import 'package:gisscope/data/model/user.dart';

class UpdateResponse {
  final User user;

  UpdateResponse(this.user);
  factory UpdateResponse.fromJson(Map<String, dynamic> json) => UpdateResponse(
        User.fromJson(json)
      );
}
