import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/app_constants.dart';

Widget backButton() {
  return GestureDetector(
    onTap: () {
      Get.toNamed(Get.previousRoute);
    },
    child: Row(
      children: [
        Icon(
          Icons.chevron_left,
          size: 26 * ffem,
        ),
        Text(
          "Back",
          style: TextStyle(fontSize: 17 * ffem),
        )
      ],
    ),
  );
}
