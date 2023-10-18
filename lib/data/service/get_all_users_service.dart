import 'package:gisscope/data/model/user.dart';
import 'package:gisscope/data/service/base_service.dart';

class GetAllUsersService extends BaseService<List<User>> {
  @override
  Future<List<User>> call() async {
    final result = await get('user');
    return List.generate(
        result['data'].length, (index) => User.fromJson(result['data'][index]));
  }
}
