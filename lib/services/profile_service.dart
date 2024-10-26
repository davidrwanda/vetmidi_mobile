import '../core/utils/app_constants.dart';
import '../core/utils/http_request.dart';

class ProfileService {
  Future<dynamic> getProfileService(String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/profile"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> updatePatientService(
    Map<String, dynamic> body,
    String token,
  ) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/profile"),
      data: body,
      method: "put",
      token: token,
    );
  }

  Future<dynamic> getClinicsConfigService(String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/configs"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> changeClinicService(
    Map<String, dynamic> body,
    String token,
  ) async {
    print("body: $body");
    return await sendHttpRequest(
      Uri.parse("$baseUrl/change-clinic"),
      data: body,
      method: "post",
      token: token,
    );
  }

  Future<dynamic> getClinicConfigService(String token, String configId) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/config/$configId"),
      method: "get",
      token: token,
    );
  }
}
