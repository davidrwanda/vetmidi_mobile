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

  Future<dynamic> getMedicalRecords(String query, String token) async {
    try {
      _fetching.value = true;
      var res =
          await _medicalRecordsService.getMedicalRecordsService(query, token);
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

  Future<dynamic> getReport(String query, String token) async {
    try {
      _fetching.value = true;
      var res = await _medicalRecordsService.getReportService(query, token);
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

  Future<dynamic> getVignetteReport(String query, String token) async {
    try {
      _fetching.value = true;
      var res =
          await _medicalRecordsService.getVignetteReportService(query, token);
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

  Future<dynamic> getPjReport(String query, String token) async {
    try {
      _fetching.value = true;
      var res = await _medicalRecordsService.getPjReportService(query, token);
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
