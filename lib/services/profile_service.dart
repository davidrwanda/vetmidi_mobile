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
}