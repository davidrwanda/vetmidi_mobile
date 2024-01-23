import 'dart:convert';
import 'dart:io';

import 'package:vetmidi/core/utils/app_constants.dart';
import 'package:vetmidi/core/utils/http_request.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<dynamic> login(Map<String, String> body) async {
    http.Response response;
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Connection": "keep-alive"
    };
    response = await http.post(Uri.parse("$baseUrl/login"), body: body);
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw const HttpException('Empty response');
    }
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
