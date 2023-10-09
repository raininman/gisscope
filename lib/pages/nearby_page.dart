import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:latlong2/latlong.dart';

class NearbyPage extends StatelessWidget {
  const NearbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(title: AppStrings.nearby),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(53.9006, 27.5590),
          zoom: 10,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 100,
                height: 60,
                point: LatLng(53.9006, 27.5590),
                builder: (context) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Username',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      )
                    ],
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
