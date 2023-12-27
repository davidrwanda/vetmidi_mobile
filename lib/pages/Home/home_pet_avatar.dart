import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/routes/index.dart';

import '../../core/utils/app_constants.dart';

GestureDetector homePetAvatar(String image, String name) {
  return GestureDetector(
    onTap: () {
      Get.find<PatientController>().patient =
          Get.find<PatientController>().patients[0];
      Get.toNamed(AppRoutes.petprofile);
    },
    child: Container(
      width: 80 * fem,
      margin: EdgeInsets.only(right: 20 * fem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80 * fem,
            margin: EdgeInsets.only(bottom: 7 * fem),
            child: ClipOval(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: 80 * fem,
            child: Text(
              name,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
