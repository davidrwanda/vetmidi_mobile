import 'package:vetmidi/core/utils/app_constants.dart';
import 'package:vetmidi/core/utils/http_request.dart';

class PatientService {
  Future<dynamic> getPatientsService(String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/patients"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> updatePatientService(
    String patientId,
    Map<String, dynamic> body,
    String token,
  ) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/patient/$patientId"),
      data: body,
      method: "put",
      token: token,
    );
  }

  Future<dynamic> createPatientService(
      Map<String, dynamic> body, String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/patient"),
      data: body,
      method: "post",
      token: token,
    );
  }

  Future<dynamic> deletePatientService(String patientId, String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/patient/$patientId"),
      method: "delete",
      token: token,
    );
  }

  Future<dynamic> getPatientService(String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/patient"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> getPetsService(String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/pets"),
      method: "get",
      token: token,
    );
  }
}
