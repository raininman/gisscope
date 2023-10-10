import 'package:gisscope/data/model/post.dart';
import 'package:gisscope/data/service/base_service.dart';

class GetPostService extends BaseService<List<Post>> {
  @override
  Future<List<Post>> call() async {
    final response = await get('post');
    return List.generate(response['data'].length,
        (index) => Post.fromJson(response['data'][index]));
  }
}
