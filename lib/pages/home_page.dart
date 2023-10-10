import 'package:flutter/material.dart';
import 'package:gisscope/components/post_item.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/config/app_routes.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/provider/post_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<PostProvider>().getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<PostProvider>(
        builder: (context, value, child) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return PostItem(post: value.list[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 24);
            },
            itemCount: value.list.length,
          );
        },
      ),
    );
  }
}
