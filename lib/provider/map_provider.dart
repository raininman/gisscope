import 'package:flutter/material.dart';
import 'package:gisscope/data/model/place.dart';
import 'package:gisscope/data/service/place_service.dart';
import 'package:gisscope/data/service/polyline_service.dart';
import 'package:gisscope/data/service/polyline_tom_service.dart';
import 'package:latlong2/latlong.dart';

class MapProvider extends ChangeNotifier {
  var category;
  var lat;
  var latMiddle;
  var latSecond;
  var latPolyline;
  var lon;
  var lonMiddle;
  var lonSecond;
  var lonPolyline;
  var radius;
  var limit;
  var places;
  var polylines;
  List<LatLng> latlng = [];

  Future<Place> getPlaces() async {
    getMiddlePlace();
    places = await GetAllPlaces(
            category: category.toString(),
            lat: latMiddle.toString(),
            lon: lonMiddle.toString(),
            radius: radius.toString(),
            limit: limit.toString())
        .call();
    return places;
  }

  getPolylines() async {
    polylines = await GetPolyline(
      lat: lat.toString(),
      lon: lon.toString(),
      lat2: latPolyline.toString(),
      lon2: lonPolyline.toString(),
    ).call();
    print(polylines.results[0].legs[0].steps[1].fromIndex);
    List<int> from = [];
    polylines.results[0].legs.forEach((leg) {
      leg.steps.forEach((step) {
        from.add(step.fromIndex);
        print(from);
      });
    });
    latlng.add(LatLng(lat, lon));
    for (int i = 0; i < from[from.length - 1]; i++) {
      if (from.contains(i)) {
        print(i);
        latlng.add(LatLng(polylines.properties.waypoints[i].lon,
            polylines.properties.waypoints[i].lat));
      }
      latlng.add(LatLng(latPolyline, lonPolyline));
      print(latlng);
    }
  }

  getTomPolylines() async {
    polylines = await GetTomPolyline(
      lat: lat.toString(),
      lon: lon.toString(),
      lat2: latPolyline.toString(),
      lon2: lonPolyline.toString(),
    ).call();
    polylines.routes[0].legs[0].points.forEach((point) {
      latlng.add(LatLng(point.latitude, point.longitude));
    });
  }

  getMiddlePlace() {
    print('$lat $lon');
    latMiddle = (lat + latSecond) / 2;
    lonMiddle = (lon + lonSecond) / 2;
    print('$latMiddle $lonMiddle');

    const distance = Distance();
    radius = distance(LatLng(latMiddle, lonMiddle), LatLng(lat, lon));
  }
}
