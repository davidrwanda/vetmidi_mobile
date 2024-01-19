import 'package:get/get.dart';
import 'package:vetmidi/components/toast.dart';
import 'package:vetmidi/models/medical_record.dart';
import 'package:vetmidi/services/medical_records_service.dart';

class MedicalRecordsController extends GetxController {
  final RxBool _fetching = false.obs;
  final RxList<MedicalRecord> _records = RxList<MedicalRecord>([]);
  final MedicalRecordsService _medicalRecordsService = MedicalRecordsService();

  bool get fetching {
    return _fetching.value;
  }

  List<MedicalRecord> get records {
    return [..._records];
  }

  Future<dynamic> getMedicalRecords(String token) async {
    try {
      _fetching.value = true;
      var res = await _medicalRecordsService.getMedicalRecordsService(token);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        List<dynamic> data = res["data"]["data"];
        List<MedicalRecord> medicalRecords =
            data.map((record) => MedicalRecord.fromJSON(record)).toList();
        _records.value = medicalRecords;
      }
    } catch (e) {
      showToast(e.toString());
    } finally {
      _fetching.value = false;
    }
  }

  Future<dynamic> getReport(String token) async {
    try {
      _fetching.value = true;
      var res = await _medicalRecordsService.getReportService(token);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        List<dynamic> data = res["data"]["data"];
        List<MedicalRecord> medicalRecords =
            data.map((record) => MedicalRecord.fromJSON(record)).toList();
        _records.value = medicalRecords;
      }
    } catch (e) {
      showToast(e.toString());
    } finally {
      _fetching.value = false;
    }
  }

  Future<dynamic> getVignetteReport(String token) async {
    try {
      _fetching.value = true;
      var res = await _medicalRecordsService.getVignetteReportService(token);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        List<dynamic> data = res["data"]["data"];
        List<MedicalRecord> medicalRecords =
            data.map((record) => MedicalRecord.fromJSON(record)).toList();
        _records.value = medicalRecords;
      }
    } catch (e) {
      showToast(e.toString());
    } finally {
      _fetching.value = false;
    }
  }

  Future<dynamic> getPjReport(String token) async {
    try {
      _fetching.value = true;
      var res = await _medicalRecordsService.getPjReportService(token);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        List<dynamic> data = res["data"]["data"];
        List<MedicalRecord> medicalRecords =
            data.map((record) => MedicalRecord.fromJSON(record)).toList();
        _records.value = medicalRecords;
      }
    } catch (e) {
      showToast(e.toString());
    } finally {
      _fetching.value = false;
    }
  }
}
