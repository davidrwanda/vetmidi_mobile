import 'package:vetmidi/core/utils/http_request.dart';

import '../core/utils/app_constants.dart';

class MedicalRecordsService {
  Future<dynamic> getMedicalRecordsService(String query, String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/medicals/$query"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> getReportService(
    String query,
    String token,
  ) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/reportRecords/$query"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> getVignetteReportService(
    String query,
    String token,
  ) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/vignetteRecords/$query"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> getPjReportService(
    String query,
    String token,
  ) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/pjRecords/$query"),
      method: "get",
      token: token,
    );
  }
}
