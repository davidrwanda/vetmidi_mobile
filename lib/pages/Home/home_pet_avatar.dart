import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/models/patients.dart';
import 'package:vetmidi/routes/index.dart';

import '../../core/utils/app_constants.dart';

GestureDetector homePetAvatar(Patient pet, String name) {
  String image = pet.webImage;
  return GestureDetector(
    onTap: () {
      Get.find<PatientController>().patient = pet;
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
              child: image == ""
                  ? Image.asset("assets/images/dog.png")
                  : Image.network(image, fit: BoxFit.cover),
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

Container homePetAvatarLoading() {
  return Container(
    width: 80 * fem,
    margin: EdgeInsets.only(right: 20 * fem),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 80 * fem,
            width: 80 * fem,
            margin: EdgeInsets.only(bottom: 7 * fem),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40 * fem),
              color: Colors.grey,
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 13 * fem,
            width: 50 * fem,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}
