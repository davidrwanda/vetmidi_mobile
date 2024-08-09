import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/app_constants.dart';

Widget backButton() {
  return GestureDetector(
    onTap: () {
      Get.back();
    },
    child: Row(
      children: [
        Icon(
          Icons.chevron_left,
          size: 26 * ffem,
        ),
        Text(
          "page.back".tr,
          style: TextStyle(fontSize: 17 * ffem),
        )
      ],
    ),
  );
}
