import 'package:flutter/material.dart';
import 'package:gisscope/styles/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GisScope"),
        backgroundColor: AppColors.background,
        actions: [
          Icon(Icons.location_on_outlined)
        ],
      ),
      body: ListView(children: [],),
    );
  }
}
