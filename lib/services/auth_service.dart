import 'package:vetmidi/core/utils/app_constants.dart';
import 'package:vetmidi/core/utils/http_request.dart';
import 'package:vetmidi/pages/Auth/change_password.dart';

class AuthService {
  Future<dynamic> login(Map<String, String> body) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/login"),
      method: 'post',
      data: body,
    );
  }

  Future<dynamic> changePasswordScreen(
      Map<String, String> body, String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/change-password"),
      method: 'post',
      token: token,
      data: body,
    );
  }
}
