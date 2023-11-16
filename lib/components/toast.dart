import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.grey,
    colorText: Colors.white,
  );
}
