import '../core/utils/app_constants.dart';
import '../core/utils/http_request.dart';

class NotificationService {
  Future<dynamic> getTreatmentsService(String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/notifications/treatment"),
      method: "get",
      token: token,
    );
  }

  Future<dynamic> getAppointmentsService(String token) async {
    return await sendHttpRequest(
      Uri.parse("$baseUrl/notifications/appointment"),
      method: "get",
      token: token,
    );
  }
}
