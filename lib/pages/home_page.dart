import 'package:flutter/material.dart';
import 'package:gisscope/components/post_item.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/config/app_routes.dart';
import 'package:gisscope/config/app_strings.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<String> users = [];

  @override
  Widget build(BuildContext context) {
    mockUsersPost();
    return Scaffold(
        appBar: Toolbar(
          title: AppStrings.appName,
          actions: [
            IconButton(
              icon: Icon(Icons.location_on_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.nearby);
              },
            ),
          ],
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
