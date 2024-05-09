import 'package:gisscope/data/model/place.dart';
import 'package:gisscope/data/service/map_base_service.dart';

class GetAllPlaces extends MapBaseService<Place> {
  final String category;
  final String lat;
  final String lon;
  final String radius;
  final String limit;

  GetAllPlaces(
      {required this.category,
      required this.lat,
      required this.lon,
      required this.radius,
      required this.limit});

  @override
  Future<Place> call() async {
    final url =
        'v2/places?categories=$category&filter=circle:$lon,$lat,$radius&bias=proximity:$lon,$lat&limit=$limit';
    final result = await get(url);
    return Place.fromJson(result);
  }
}
