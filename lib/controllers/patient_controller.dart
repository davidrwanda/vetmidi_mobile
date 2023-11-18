import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/toast.dart';
import 'package:vetmidi/models/patients.dart';
import 'package:vetmidi/models/pet_file.dart';
import 'package:vetmidi/services/patient_service.dart';

import 'package:http/http.dart' as http;

class PatientController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isUpLoading = false.obs;
  final RxBool _fetchedPatients = false.obs;
  final RxList<Patient> _patients = RxList<Patient>([]);
  final RxList<PetFile> _petFiles = RxList<PetFile>([]);
  final Rx<Patient?> _patient = Rx<Patient?>(null);
  final PatientService _patientService = PatientService();

  List<Patient> get patients {
    return [..._patients];
  }

  List<PetFile> get petFiles {
    return [..._petFiles];
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

  bool get uploading {
    return _isUpLoading.value;
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

  Future<void> updatePatient(
      String patientId, Map<String, dynamic> body, String token) async {
    try {
      _isLoading.value = true;
      var res =
          await _patientService.updatePatientService(patientId, body, token);
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

  Future<void> createPatient(Map<String, dynamic> body, String token) async {
    try {
      _isLoading.value = true;
      var res = await _patientService.createPatientService(body, token);
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

  Future<void> getPetFiles(String petId, String token) async {
    try {
      _isLoading.value = true;
      var res = await _patientService.getPetFilesService(petId, token);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        List<dynamic> data = res["data"];
        List<PetFile> petFiles = data.map((e) => PetFile.fromJSON(e)).toList();
        _petFiles.value = petFiles;
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> uploadPetDocuments(
      List<PlatformFile> files, String petId, String token) async {
    try {
      _isUpLoading.value = true;
      for (var file in files) {
        File f = File.fromUri(Uri.file(file.path!));
        // print("file $f");
        Uint8List? fileBytes = await f.readAsBytes();
        // print("file uploadd  ${file.name} bytessssssssssssssss ${file.bytes}");
        if (fileBytes != null) {
          Map<String, dynamic> data = {
            "type": "application/pdf",
            "name": file.name,
            "file": file
          };
          var res = await _patientService.uploadPetDocument(data, petId, token);
          // print("dataaaaaaaaaaaa $data");
          // print("ressssssssssssssssss $res");
          if (res["error"] != null && res["error"] == true) {
            throw Exception(res["message"]);
          }
        }
      }
    } catch (error) {
      print(error.toString());
      showToast(error.toString());
    } finally {
      _isUpLoading.value = false;
    }
  }
}
