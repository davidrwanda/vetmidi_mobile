import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vetmidi/core/utils/app_constants.dart';
import 'package:vetmidi/core/utils/http_request.dart';

class AuthService {
  Future<dynamic> login(Map<String, String> body) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/login"),
      method: 'post',
      data: body,
    );
  }
}
