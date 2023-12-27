import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/pages/Home/appointments_card.dart';
import 'package:vetmidi/routes/index.dart';

import '../../core/utils/app_constants.dart';

Widget appointmentList() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Appointments",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14 * ffem,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.appointments),
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
      appointmentCard(),
    ],
  );
}
