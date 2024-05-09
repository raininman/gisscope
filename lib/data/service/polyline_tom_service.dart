import 'package:gisscope/data/model/polylineTom.dart';
import 'package:gisscope/data/service/map_base_service.dart';

class GetTomPolyline extends MapBaseService<PolylineTom> {
  final String lat;
  final String lat2;
  final String lon;
  final String lon2;

  GetTomPolyline({
    required this.lat,
    required this.lon,
    required this.lat2,
    required this.lon2,
  });

  @override
  Future<PolylineTom> call() async {
    final url = '$lat,$lon:$lat2,$lon2/json?';
    final result = await tomGet(url);
    return PolylineTom.fromJson(result);
  }
}
