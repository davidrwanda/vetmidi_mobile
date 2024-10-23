import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vetmidi/core/utils/toast.dart';
import 'package:vetmidi/models/patients.dart';
import 'package:vetmidi/models/pet_file.dart';
import 'package:vetmidi/services/patient_service.dart';

class PatientController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isUpLoading = false.obs;
  final RxList<Patient> _patients = RxList<Patient>([]);
  final Rx<Patient?> _patient = Rx<Patient?>(null);
  final RxList<PetFile> _petFiles = RxList<PetFile>([]);
  final PatientService _patientService = PatientService();

  List<Patient> get patients {
    return [..._patients];
  }

  Patient? get patient {
    return _patient.value;
  }

  Patient? getPetById(String id) {
    List<Patient> pets =
        _patients.where((element) => element.fmId == id).toList();
    if (pets.isNotEmpty) {
      return pets[0];
    } else {
      return null;
    }
  }

  List<PetFile> get petFiles {
    return [..._petFiles];
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

  void resetPetsState() {
    _patients.value = [];
    _petFiles.value = [];
  }

  Future<void> getPatients(String token) async {
    try {
      _isLoading.value = true;
      var res = await _patientService.getPatientsService(token);
      if (res["error"] != null && res["error"] == true) {
        errorToast(res["message"]);
      } else {
        List<dynamic>? data = res["data"];
        if (data != null) {
          if (data[0]["isempty"] != null && data[0]["isempty"] == true) {
          } else {
            List<Patient> patients =
                data.map((e) => Patient.fromJSON(e)).toList();
            _patients.value = patients;
          }
        }
      }
    } catch (error) {
      successToast(error.toString());
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
        errorToast(res["message"]);
      } else {
        successToast("page.pets.updateSuccess".tr);
      }
    } catch (error) {
      successToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> createPatient(Map<String, dynamic> body, String token) async {
    try {
      _isLoading.value = true;
      var res = await _patientService.createPatientService(body, token);
      if (res["error"] != null && res["error"] == true) {
        errorToast(res["message"]);
      } else {
        successToast("page.pets.petAddedSuccess".tr);
      }
    } catch (error) {
      successToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getPetFiles(String petId, String token) async {
    try {
      _isLoading.value = true;
      var res = await _patientService.getPetFilesService(petId, token);
      if (res["error"] != null && res["error"] == true) {
        errorToast(res["message"]);
      } else {
        List<dynamic> data = res["data"];
        List<PetFile> petFiles = data.map((e) => PetFile.fromJSON(e)).toList();
        _petFiles.value = petFiles;
      }
    } catch (error) {
      successToast(error.toString());
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
        Uint8List? fileBytes = await f.readAsBytes();
        await _patientService.uploadPetDocument(
            file.name, fileBytes, petId, token);
      }
    } catch (error) {
      successToast(error.toString());
    } finally {
      _isUpLoading.value = false;
    }
  }
}
