import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/components/user_avatar.dart';
import 'package:gisscope/components/user_page_item.dart';
import 'package:gisscope/config/app_config.dart';
import 'package:gisscope/data/model/user.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/map_provider.dart';
import 'package:gisscope/provider/user_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class NearbyPage extends StatefulWidget {
  const NearbyPage({super.key});

  @override
  State<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  final pageController = PageController(viewportFraction: 0.85);
  late final Future<List<User>> futureUsers;
  var places;
  var init = false;

  @override
  void initState() {
    futureUsers = context.read<UserProvider>().getAllUsers();
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext builderContext) {
    return Scaffold(
      appBar: Toolbar(title: "nearby".tr),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!;
          return Stack(children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(
                    builderContext.read<AppRepo>().user!.location!.lat,
                    builderContext.read<AppRepo>().user!.location!.lng),
                zoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://maps.geoapify.com/v1/tile/dark-matter-brown/{z}/{x}/{y}.png?apiKey=5f4b6440389a4594a09477f2cbd56664',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [
                        ...builderContext
                                .read<MapProvider>()
                                .latlng ?? List.empty(),
                      ],
                      color: Colors.blue,
                      strokeWidth: 1,
                    ),
                  ],
                ),
                MarkerLayer(markers: [
                  ...users
                      .map<Marker>((user) => Marker(
                            width: 300,
                            height: 100,
                            point: LatLng(user.location?.lat ?? 0.0,
                                user.location?.lng ?? 0.0),
                            builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  var page = 0;
                                  for (var i = 0; i < users.length; i++) {
                                    if (users[i].id == user.id) {
                                      page = i;
                                      break;
                                    }
                                  }
                                  pageController.animateToPage(page,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 8,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(14),
                                        ),
                                      ),
                                      child: Text(
                                        user.username,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    CustomPaint(
                                      painter: MarkerPainter(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipPath(
                                          clipper: MarkerClipper(),
                                          child: SizedBox(
                                              height: 60,
                                              width: 48,
                                              child: UserAvatar(
                                                  size: 60,
                                                  path:
                                                      '${AppConfig.baseURL}${user.avatar}')),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ))
                      .toList(),
                  ...builderContext
                          .read<MapProvider>()
                          .places
                          ?.features
                          .map<Marker>((place) => Marker(
                              width: 100,
                              height: 100,
                              point: LatLng(place.properties!.lat!,
                                  place.properties!.lon!),
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () async => {
                                    builderContext
                                        .read<MapProvider>()
                                        .latPolyline = place.properties!.lat!,
                                    builderContext
                                        .read<MapProvider>()
                                        .lonPolyline = place.properties!.lon!,
                                        builderContext
                                .read<MapProvider>()
                                .latlng = [],
                                    await builderContext
                                        .read<MapProvider>()
                                        .getTomPolylines(),
                                    refresh(),
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 8,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(14),
                                          ),
                                        ),
                                        child: Text(
                                          '${place.properties?.name}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 7),
                                        ),
                                      ),
                                      CustomPaint(
                                        painter: MarkerPainter(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: ClipPath(
                                              clipper: MarkerClipper(),
                                              child: const SizedBox(
                                                  height: 20,
                                                  width: 18,
                                                  child: UserAvatar(size: 60))),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }))
                          .toList() ??
                      List.empty()
                ])
              ],
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 100,
              child: SizedBox(
                height: 300,
                child: PageView(
                  controller: pageController,
                  children: users
                      .map((user) =>
                          UserPageItem(user: user, notifyParent: refresh))
                      .toList(),
                ),
              ),
            ),
          ]);
        },
        future: futureUsers,
      ),
    );
  }
}

ui.Path _getPath(Size size) {
  final path = ui.Path();
  path.moveTo(size.width / 2, size.height);
  path.quadraticBezierTo(-1, (size.height / 2) + 12, 0, size.height / 2);
  final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height);
  path.arcTo(rect, math.pi, math.pi, true);
  path.quadraticBezierTo(
      size.width + 1, (size.height / 2) + 12, size.width / 2, size.height);
  return path;
}

class MarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    final path = _getPath(size);

    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.black87, 6, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MarkerClipper extends CustomClipper<ui.Path> {
  @override
  ui.Path getClip(Size size) {
    return _getPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
