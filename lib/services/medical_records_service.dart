import 'package:vetmidi/core/utils/http_request.dart';

import '../core/utils/app_constants.dart';

class MedicalRecordsService {
  Future<dynamic> getMedicalRecordsService(String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/medicals"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> getReportService(
    String token,
  ) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/reportRecords"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> getVignetteReportService(
    String token,
  ) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/vignetteRecords"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> getPjReportService(
    String token,
  ) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/medicals/*"),
      method: "get",
      token: token,
    );
  }
}
