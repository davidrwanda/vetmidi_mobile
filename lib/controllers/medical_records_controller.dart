import 'package:get/get.dart';
import 'package:vetmidi/core/utils/toast.dart';
import 'package:vetmidi/models/medical_record.dart';
import 'package:vetmidi/services/medical_records_service.dart';

class MedicalRecordsController extends GetxController {
  final RxBool _fetching = false.obs;
  final RxList<MedicalRecord> _records = RxList<MedicalRecord>([]);
  final MedicalRecordsService _medicalRecordsService = MedicalRecordsService();
  
  bool get fetching => _fetching.value;
  List<MedicalRecord> get records => [..._records];

  Future<T> _retryOperation<T>(Future<T> Function() operation, {int maxRetries = 3}) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        return await operation();
      } catch (error) {
        if (attempt == maxRetries) {
          rethrow;
        }
        await Future.delayed(Duration(seconds: 1 * attempt));
      }
    }
    throw Exception('Operation failed after $maxRetries attempts');
  }

  Future<void> getMedicalRecords(String query, String token) async {
    try {
      _fetching.value = true;
      await _retryOperation(() async {
        var res = await _medicalRecordsService.getMedicalRecordsService(query, token);
        if (res["error"] != null && res["error"] == true) {
          throw Exception(res["message"]);
        } else {
          List<dynamic> data = res["data"]["data"];
          List<MedicalRecord> medicalRecords =
              data.map((record) => MedicalRecord.fromJSON(record)).toList();
          _records.value = medicalRecords;
        }
      });
    } catch (e) {
      errorToast(e.toString());
    } finally {
      _fetching.value = false;
    }
  }

  Future<void> getReport(String query, String token) async {
    try {
      _fetching.value = true;
      await _retryOperation(() async {
        var res = await _medicalRecordsService.getReportService(query, token);
        if (res["error"] != null && res["error"] == true) {
          throw Exception(res["message"]);
        } else {
          List<dynamic> data = res["data"]["data"];
          List<MedicalRecord> medicalRecords =
              data.map((record) => MedicalRecord.fromJSON(record)).toList();
          _records.value = medicalRecords;
        }
      });
    } catch (e) {
      errorToast(e.toString());
    } finally {
      _fetching.value = false;
    }
  }

  Future<void> getVignetteReport(String query, String token) async {
    try {
      _fetching.value = true;
      await _retryOperation(() async {
        var res = await _medicalRecordsService.getVignetteReportService(query, token);
        if (res["error"] != null && res["error"] == true) {
          throw Exception(res["message"]);
        } else {
          List<dynamic> data = res["data"]["data"];
          List<MedicalRecord> medicalRecords =
              data.map((record) => MedicalRecord.fromJSON(record)).toList();
          _records.value = medicalRecords;
        }
      });
    } catch (e) {
      errorToast(e.toString());
    } finally {
      _fetching.value = false;
    }
  }

  Future<void> getPjReport(String query, String token) async {
    try {
      _fetching.value = true;
      await _retryOperation(() async {
        var res = await _medicalRecordsService.getPjReportService(query, token);
        if (res["error"] != null && res["error"] == true) {
          throw Exception(res["message"]);
        } else {
          List<dynamic> data = res["data"]["data"];
          List<MedicalRecord> medicalRecords =
              data.map((record) => MedicalRecord.fromJSON(record)).toList();
          _records.value = medicalRecords;
        }
      });
    } catch (e) {
      errorToast(e.toString());
    } finally {
      _fetching.value = false;
    }
  }
}
