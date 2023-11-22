import 'package:get/get.dart';
import 'package:vetmidi/controllers/medical_records_controller.dart';
import 'package:vetmidi/controllers/patient_controller.dart';

import '../../controllers/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PatientController());
    Get.put(ProfileController());
    Get.put(MedicalRecordsController());
  }
}
