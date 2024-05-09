import 'package:flutter/material.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/data/model/user.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/map_provider.dart';
import 'package:gisscope/styles/app_text.dart';
import 'package:provider/provider.dart';

enum CategoriesMenu { commercial, catering, entertainment, none }

class UserPageItem extends StatefulWidget {
  final User user;
  final Function() notifyParent;
  const UserPageItem(
      {super.key, required this.user, required this.notifyParent});

  @override
  State<UserPageItem> createState() => _UserPageItemState();
}

class _UserPageItemState extends State<UserPageItem> {
  refresh() {
    setState(() {
      print("refresh");
    });
  }

  @override
  Widget build(BuildContext context) {
    bool category = false;
    CategoriesMenu menu = CategoriesMenu.none;

    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Column(children: [
        Row(
          children: [
            UserAvatar(
                size: 50, path: '${AppConfig.baseURL}${widget.user.avatar}'),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.user.firstname} ${widget.user.lastname}',
                  style: AppText.body1Semibold.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  widget.user.visibleGender ?? false
                      ? widget.user.gender ?? ''
                      : '',
                  style: AppText.body1Semibold.copyWith(color: Colors.black),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.black),
                  width: 50,
                  child: PopupMenuButton<CategoriesMenu>(
                    icon: Icon(menu == CategoriesMenu.catering
                        ? Icons.fastfood
                        : menu == CategoriesMenu.commercial
                            ? Icons.shopping_bag
                            : menu == CategoriesMenu.entertainment
                                ? Icons.movie_creation_outlined
                                : Icons.menu),
                    onSelected: (value) {
                      switch (value) {
                        case CategoriesMenu.commercial:
                          category = true;
                          menu = CategoriesMenu.commercial;
                          context.read<MapProvider>().category = "commercial";
                          refresh;
                          break;
                        case CategoriesMenu.catering:
                          category = true;
                          menu = CategoriesMenu.catering;
                          context.read<MapProvider>().category = "catering";
                          refresh;
                          break;
                        case CategoriesMenu.entertainment:
                          category = true;
                          menu = CategoriesMenu.entertainment;
                          context.read<MapProvider>().category =
                              "entertainment";
                          refresh;
                          break;
                        default:
                          print("Error");
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: CategoriesMenu.commercial,
                          child: Text("commercial"),
                        ),
                        const PopupMenuItem(
                          value: CategoriesMenu.catering,
                          child: Text("catering"),
                        ),
                        const PopupMenuItem(
                          value: CategoriesMenu.entertainment,
                          child: Text("entertainment"),
                        ),
                      ];
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async => {
                          if (category)
                            {
                              context.read<MapProvider>().latSecond =
                                  widget.user.location?.lat,
                              context.read<MapProvider>().lat =
                                  context.read<AppRepo>().user!.location!.lat,
                              context.read<MapProvider>().lonSecond =
                                  widget.user.location?.lng,
                              context.read<MapProvider>().lon =
                                  context.read<AppRepo>().user!.location!.lng,
                              context.read<MapProvider>().limit = 20,
                              await context.read<MapProvider>().getPlaces(),
                              refresh(),
                              widget.notifyParent()
                            }
                        },
                    child:
                        Text(category ? 'Найти места' : 'Выберете категорию')),
              ],
            ),
          ],
        ),
        Text(
          widget.user.location?.name ?? '',
          style: AppText.body1.copyWith(color: Colors.black),
        ),
      ]),
    );
  }
}
