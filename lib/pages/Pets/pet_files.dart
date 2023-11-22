import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/patient_controller.dart';

import '../../core/utils/app_constants.dart';

class PetFiles extends StatelessWidget {
  const PetFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Get.find<PatientController>().petFiles.isEmpty
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff1C2232),
                      borderRadius: BorderRadius.circular(20 * fem)),
                  child: Center(
                    child: Text(
                      "page.pet.Nofiles".tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : Container(
                  height: 350 * fem,
                  padding: EdgeInsets.only(bottom: 40 * fem),
                  child: ListView(
                    children: [
                      ...Get.find<PatientController>().petFiles.map(
                            (file) => Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10 * fem, horizontal: 10 * fem),
                              margin: EdgeInsets.symmetric(vertical: 10 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1C2232),
                                  borderRadius:
                                      BorderRadius.circular(10 * fem)),
                              child: Row(children: [
                                const Icon(
                                  Icons.insert_drive_file,
                                  color: Color(0xffcde70a),
                                ),
                                SizedBox(width: 10 * fem),
                                Expanded(
                                  child: Text(
                                    file.filename,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const Icon(Icons.download,
                                    color: Color(0xffcde70a))
                              ]),
                            ),
                          )
                    ],
                  ),
                )
        ],
      );
    });
  }
}
