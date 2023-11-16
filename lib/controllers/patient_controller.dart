import 'package:get/get.dart';
import 'package:vetmidi/components/toast.dart';
import 'package:vetmidi/models/patients.dart';
import 'package:vetmidi/services/patient_service.dart';

class PatientController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _fetchedPatients = false.obs;
  final RxList<Patient> _patients = RxList<Patient>([]);
  final Rx<Patient?> _patient = Rx<Patient?>(null);
  final PatientService _patientService = PatientService();

  List<Patient> get patients {
    return [..._patients];
  }

  Patient? get patient {
    return _patient.value;
  }

  set patient(Patient? inPatient) {
    _patient.value = inPatient;
  }

  bool get loading {
    return _isLoading.value;
  }

  bool get fetchedPatients {
    return _fetchedPatients.value;
  }

  Future<void> getPatients(String token) async {
    try {
      _isLoading.value = true;
      var res = await _patientService.getPatientsService(token);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        List<dynamic> data = res["data"];
        List<Patient> patients = data.map((e) => Patient.fromJSON(e)).toList();
        _patients.value = patients;
        _fetchedPatients.value = true;
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  // Future<void> updatePatient(
  //   String patientId,
  //   Map<String, dynamic> body,
  //   String token,
  // ) async {
  //   return await sendHttpRequest(
  //     Uri.parse("$baseUrl/patient/$patientId"),
  //     data: body,
  //     method: "put",
  //     token: token,
  //   );
  // }

  Future<void> createPatient(Map<String, dynamic> body, String token) async {
    try {
      _isLoading.value = true;
      var res = await _patientService.createPatientService(body, token);
      print("resssssssssssssssssssss $res");
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        _fetchedPatients.value = false;
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  // Future<void> deletePatient(String patientId, String token) async {
  //   return await sendHttpRequest(
  //     Uri.parse("$baseUrl/patient/$patientId"),
  //     method: "delete",
  //     token: token,
  //   );
  // }

  // Future<void> getPatient(String token) async {
  //   return await sendHttpRequest(
  //     Uri.parse("$baseUrl/patient"),
  //     method: "get",
  //     token: token,
  //   );
  // }

  // Future<void> getPets(String token) async {
  //   return await sendHttpRequest(
  //     Uri.parse("$baseUrl/pets"),
  //     method: "get",
  //     token: token,
  //   );
  // }
}
