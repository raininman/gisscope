import 'package:flutter/material.dart';
import 'package:gisscope/data/model/user.dart';
import 'package:gisscope/data/service/get_all_users_service.dart';

class UserProvider extends ChangeNotifier {
  Future<List<User>> getAllUsers() async {
    return await GetAllUsersService().call();
  }
}
