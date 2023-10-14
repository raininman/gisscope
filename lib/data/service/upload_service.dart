import 'package:gisscope/data/service/base_service.dart';

class UploadService extends BaseService<String> {
  final String path;

  UploadService(this.path);
  @override
  Future<String> call() async {
    final result = await upload('upload', 'photo', path);
    return result['data']['url'];
  }
}
