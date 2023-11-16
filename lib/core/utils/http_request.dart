import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<dynamic> sendHttpRequest(Uri url,
    {Object data = const {},
    String method = "get",
    Map<String, String> header = const {},
    String token = ''}) async {
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Connection": "keep-alive"
  };
  headers = {...headers, ...header};
  if (token != '') headers["Authorization"] = "Bearer $token";
  try {
    http.Response response;
    if (method == 'patch') {
      response =
          await http.patch(url, body: json.encode(data), headers: headers);
    } else if (method == 'put') {
      response = await http.put(url, body: json.encode(data), headers: headers);
    } else if (method == 'get') {
      response = await http.get(url, headers: headers);
    } else if (method == 'delete') {
      response = await http.delete(url, headers: headers);
    } else {
      response =
          await http.post(url, body: json.encode(data), headers: headers);
    }
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw const HttpException('Empty response');
    }
  } catch (error) {
    if (error.toString().contains("Failed host lookup") ||
        error
            .toString()
            .contains("OS Error: Software caused connection abort")) {
      throw const HttpException('no internet');
    } else if (error is SocketException) {
      throw const HttpException("Server Connection Error, Try again");
    } else if (error.toString().contains('HTTP Status 500')) {
      throw const HttpException("Internal Server Error");
    } else {
      throw const HttpException("Error!");
    }
  }
}
