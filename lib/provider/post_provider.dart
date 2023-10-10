import 'package:flutter/material.dart';
import 'package:gisscope/data/model/post.dart';
import 'package:gisscope/data/service/create_post_service.dart';
import 'package:gisscope/data/service/get_post_service.dart';

class PostProvider extends ChangeNotifier {
  final List<Post> list = [];
  String message = '';

  getPosts() async {
    list.clear();
    list.addAll(await GetPostService().call());
    notifyListeners();
  }

  Future<void> createPost(String token) async {
    await CreatePostService(message, null, token).call();
    message = '';
    getPosts();
  }
}
