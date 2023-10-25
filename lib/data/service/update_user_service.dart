import 'package:gisscope/data/service/base_service.dart';

class UpdateUserService extends BaseService {
  final String lastname;
  final String firstname;
  final String phoneNumber;
  final Map<String, dynamic> location;
  final String birthday;
  final String gender;
  final String token;
  final String? image;
  final bool visibleGender;

  UpdateUserService(
      {required this.lastname,
      required this.firstname,
      required this.phoneNumber,
      required this.location,
      required this.birthday,
      required this.gender,
      required this.token,
      required this.image,
      required this.visibleGender,});
  @override
  Future<String> call() async {
    final body = {
      'lastname': lastname,
      'firstname': firstname,
      'phoneNumber': phoneNumber,
      'location': location,
      'gender': gender,
      'avatar': image,
      'birthday': birthday,
      'visibleOnProfile': visibleGender,
    };
    final result = await put('user', body: body, token: token);
    final message = result['message'];
    return message;
  }
}
