import 'package:gisscope/data/model/polyline.dart';
import 'package:gisscope/data/service/map_base_service.dart';

class GetPolyline extends MapBaseService<Polyline> {
  final String lat;
  final String lat2;
  final String lon;
  final String lon2;

  GetPolyline({
    required this.lat,
    required this.lon,
    required this.lat2,
    required this.lon2,
  });

  @override
  Future<Polyline> call() async {
    final url = 'v1/routing?waypoints=$lon,$lat|$lon2,$lat2&mode=drive&type=short&format=json';
    final result = await get(url);
    return Polyline.fromJson(result);
  }
}
