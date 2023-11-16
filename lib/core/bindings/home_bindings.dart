import 'package:get/get.dart';
import 'package:vetmidi/controllers/patient_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PatientController());
  }
}
