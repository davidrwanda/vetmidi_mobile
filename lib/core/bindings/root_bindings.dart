import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
