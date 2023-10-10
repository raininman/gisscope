import 'package:flutter/material.dart';
import 'package:gisscope/data/model/post.dart';
import 'package:gisscope/data/service/get_post_service.dart';

class PostProvider extends ChangeNotifier {
  final List<Post> list = [];

  getPosts() async {
    list.clear();
    list.addAll(await GetPostService().call());
    notifyListeners();
  }
}
