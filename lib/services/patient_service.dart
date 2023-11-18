import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:vetmidi/core/utils/app_constants.dart';
import 'package:vetmidi/core/utils/http_request.dart';
import 'package:http/http.dart' as http;

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

  Future<dynamic> getPetFilesService(String petId, String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/pets/$petId"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> uploadPetDocument(
      Map<String, dynamic> data, String petId, String token) async {
    Map<String, String> headers = {
      "Accept": "*/*",
      "Content-Type": "application/x-www-form-urlencoded",
      "Connection": "keep-alive",
      "Authorization": "Bearer $token"
    };
    print("htt payload $data");
    http.Response response = await http.post(
        Uri.parse("$baseUrl/postPetFiles/$petId"),
        body: data,
        headers: headers);

    print("htt presonse ${response.body}");
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw const HttpException('Empty response');
    }
  }
}
