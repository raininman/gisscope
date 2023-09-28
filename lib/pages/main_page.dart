import 'package:flutter/material.dart';
import 'package:gisscope/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 24), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined, size: 24),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 24,
              ),
              label: "Add post"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.messenger_outline,
                size: 24,
              ),
              label: "Message"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 24,
              ),
              label: "Profile"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  final pages = [
    HomePage(),
    Center(
      child: Text("Favorite"),
    ),
    Center(
      child: Text("Add"),
    ),
    Center(
      child: Text("Messages"),
    ),
    Center(
      child: Text("User"),
    ),
  ];
}
