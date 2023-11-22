import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/app_constants.dart';

void showToast(String message, {String title = "Error"}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.grey,
    colorText: Colors.white,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showNotification(
    BuildContext context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: AnimatedContainer(
        width: Get.width,
        height: 6 * fem,
        duration: const Duration(seconds: 3),
        transformAlignment: Alignment.centerRight,
        curve: Curves.linear,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4CD964),
              Color(0xFF5AC8FA),
              Color(0xFF007AFF),
              Color(0xFF34AADC),
              Color(0xFF5856D6),
              Color(0xFFFF2D55),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    ),
  );
}
