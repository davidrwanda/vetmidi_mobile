import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/pages/Home/treatment_card.dart';

import '../../core/utils/app_constants.dart';
import '../../routes/index.dart';

Widget treatmentList() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Treatments",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14 * ffem,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.treatments),
            child: Text(
              "View All",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13 * ffem,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10 * fem),
      treatmentCard(),
    ],
  );
}
