import 'package:flutter/material.dart';
import 'package:gisscope/components/app_bottom_navigation_item.dart';
import 'package:gisscope/components/new_post_modal.dart';
import 'package:gisscope/pages/home_page.dart';
import 'package:gisscope/pages/profile_page.dart';
import 'package:gisscope/styles/app_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Menus currentIndex = Menus.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex.index],
      extendBody: true,
      bottomNavigationBar: AppBottomNavigationBar(
        onTap: (Menus value) {
          if (value == Menus.add) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return NewPostModal();
              },
            );
            return;
          }
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
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
    ProfilePage(),
  ];
}

enum Menus { home, favorite, add, messages, profile }

class AppBottomNavigationBar extends StatelessWidget {
  final Menus currentIndex;
  final ValueChanged<Menus> onTap;
  const AppBottomNavigationBar(
      {super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      margin: EdgeInsets.all(24),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 17,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppBottomNavigationBarItem(
                      onPressed: () => onTap(Menus.home),
                      icon: Icons.home_outlined,
                      current: currentIndex,
                      name: Menus.home,
                    ),
                  ),
                  Expanded(
                    child: AppBottomNavigationBarItem(
                      onPressed: () => onTap(Menus.favorite),
                      icon: Icons.favorite_border_outlined,
                      current: currentIndex,
                      name: Menus.favorite,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: AppBottomNavigationBarItem(
                      onPressed: () => onTap(Menus.messages),
                      icon: Icons.messenger_outline,
                      current: currentIndex,
                      name: Menus.messages,
                    ),
                  ),
                  Expanded(
                    child: AppBottomNavigationBarItem(
                      onPressed: () => onTap(Menus.profile),
                      icon: Icons.person_outline,
                      current: currentIndex,
                      name: Menus.profile,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: () => onTap(Menus.add),
                child: Icon(
                  Icons.add,
                  size: 24,
                  color: (currentIndex == Menus.add)
                      ? AppColors.black
                      : AppColors.black.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
