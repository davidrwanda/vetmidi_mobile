import 'dart:convert';
import 'dart:io';

import 'package:vetmidi/core/utils/app_constants.dart';
import 'package:vetmidi/core/utils/http_request.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<dynamic> login(Map<String, String> body) async {
    http.Response response;
    response = await http.post(Uri.parse("$baseUrl/login"), body: body);
    int maxAttempts = 1;
    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      response = await http.post(Uri.parse("$baseUrl/login"), body: body);
      if (attempt >= maxAttempts - 1) {
        break; // If this was the last attempt, rethrow the exception
      }
    }
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw const HttpException('Empty response');
    }
  }

  Future<dynamic> signupService(Map<String, String> body) async {
    http.Response response;
    response =
        await http.post(Uri.parse("$baseUrl/mobile-register"), body: body);
        await this.resendOTPService(body);
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw const HttpException('Empty response');
    }
  }

  Future<dynamic> verifyOTPService(Map<String, String> body) async {
    http.Response response;
    response = await http.post(Uri.parse("$baseUrl/otp-verify"), body: body);
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw const HttpException('Empty response');
    }
  }

  Future<dynamic> resendOTPService(Map<String, String> body) async {
    http.Response response;
    response = await http.post(Uri.parse("$baseUrl/resend-otp"), body: body);
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw const HttpException('Empty response');
    }
  }

  Future<dynamic> forgotPasswordService(Map<String, String> body) async {
    http.Response response;
    response = await http.post(Uri.parse("$baseUrl/mobile-forget-password"),
        body: body);
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw const HttpException('Empty response');
    }
  }

  Future<dynamic> resetPasswordService(Map<String, String> body) async {
    http.Response response;
    response = await http.post(Uri.parse("$baseUrl/mobile-reset-password"),
        body: body);
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw const HttpException('Empty response');
    }
  }

  Future<dynamic> getClinicsService() async {
    http.Response response;
    response = await http.get(Uri.parse("$baseUrl/clinics"));
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
