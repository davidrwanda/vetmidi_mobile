import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
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
      String name, Uint8List fileBytes, String petId, String token) async {
    Map<String, String> headers = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Connection": "keep-alive",
      "Authorization": "Bearer $token"
    };
    // print("htt payload $data");
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/postPetFiles/$petId"),
    );

    // Add headers to the request
    request.headers.addAll(headers);

    // Add form fields
    // request.fields['type'] = 'application/pdf';
    // request.fields['name'] = name;

    // Add file to the request
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: name,
        contentType: MediaType('application', 'pdf'),
      ),
    );

    http.StreamedResponse response = await request.send();
    // http.Response response = await http.post(
    //     Uri.parse("$baseUrl/postPetFiles/$petId"),
    //     body: data,
    //     headers: headers);

    if (response.statusCode == 200) {
      // print('Request successful');
      // print('Response: ${await response.stream.bytesToString()}');
    } else {
      // print('Request failed with status: ${response.statusCode}');
    }
    // if (response.body.isNotEmpty) {
    //   return json.decode(response.body);
    // } else {
    //   throw const HttpException('Empty response');
    // }
  }
}
