import 'package:flutter/material.dart';
import 'package:gisscope/components/post_item.dart';
import 'package:gisscope/styles/app_colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<String> users = [];

  @override
  Widget build(BuildContext context) {
    mockUsersPost();
    return Scaffold(
        appBar: AppBar(
          title: Text("GisScope"),
          backgroundColor: AppColors.background,
          actions: [Icon(Icons.location_on_outlined)],
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return PostItem(user: users[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 24);
            },
            itemCount: users.length));
  }

  mockUsersPost() {
    for (int i = 0; i < 100; i++) {
      users.add("User $i");
    }
  }
}
