import 'package:get/get.dart';
import 'package:vetmidi/models/notification.dart';
import 'package:vetmidi/services/notifications_service.dart';

import '../components/toast.dart';

class NotificationController extends GetxController {
  final RxBool _fetchingAppointments = false.obs;
  final RxBool _fetchingTreatments = false.obs;
  final RxBool _fetchedAppointments = false.obs;
  final RxBool _fetchedTreatments = false.obs;
  final RxList<NotificationModel> _treatments = RxList<NotificationModel>([]);
  final Rx<NotificationModel?> _treatment = Rx<NotificationModel?>(null);
  final RxList<NotificationModel> _appointments = RxList<NotificationModel>([]);
  final Rx<NotificationModel?> _appointment = Rx<NotificationModel?>(null);
  final Rx<NotificationModel?> _notification = Rx<NotificationModel?>(null);
  final NotificationService _notificationService = NotificationService();

  bool get fetchingAppointments {
    return _fetchingAppointments.value;
  }

  bool get fetchingTreatments {
    return _fetchingTreatments.value;
  }

  set appointment(NotificationModel? inAppointment) {
    _appointment.value = inAppointment;
  }

  NotificationModel? get appointment {
    return _appointment.value;
  }

  set treatment(NotificationModel? inTreatment) {
    _treatment.value = inTreatment;
  }

  NotificationModel? get treatment {
    return _treatment.value;
  }

  List<NotificationModel> get treatments {
    return [..._treatments];
  }

  List<NotificationModel> getPetTreatments(String petId) {
    return _treatments.where((treatment) => treatment.pet_id == petId).toList();
  }

  List<NotificationModel> getPetAppointments(String petId) {
    List<NotificationModel> petAppointments = _appointments
        .where((appointment) => appointment.pet_id == petId)
        .toList();
    return petAppointments;
  }

  List<NotificationModel> get appointments {
    return [..._appointments];
  }

  NotificationModel? get notification {
    return _notification.value;
  }

  bool get fetchedAppointments {
    return _fetchedAppointments.value;
  }

  bool get fetchedTreatments {
    return _fetchedTreatments.value;
  }

  void resetNotificationsState() {
    _appointments.value = [];
    _appointment.value = null;
    _treatments.value = [];
    _treatment.value = null;
  }

  Future<void> getTreatments(String token) async {
    try {
      _fetchingTreatments.value = true;
      var res = await _notificationService.getTreatmentsService(token);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        List<dynamic> data = res["data"];
        List<NotificationModel> treatments =
            data.map((e) => NotificationModel.fromJSON(e)).toList();
        _treatments.value = treatments;
        _fetchedTreatments.value = true;
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _fetchingTreatments.value = false;
    }
  }

  Future<void> getAppointments(token) async {
    try {
      _fetchingAppointments.value = true;
      var res = await _notificationService.getAppointmentsService(token);

      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        List<dynamic> data = res["data"];
        List<NotificationModel> appointments =
            data.map((e) => NotificationModel.fromJSON(e)).toList();
        _appointments.value = appointments;
        _fetchedAppointments.value = true;
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _fetchingAppointments.value = false;
    }
  }
}
