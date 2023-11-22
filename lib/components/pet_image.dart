import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';

import '../core/utils/app_constants.dart';

Container petImage(String image, bool isNew) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50 * fem),
      border: Border.all(
        color: ThemeColors.primaryGrey4,
      ),
    ),
    height: 100 * fem,
    width: 100 * fem,
    child: ClipOval(
      child: !isNew
          ? image.isEmpty
              ? Image.asset("assets/images/dog.png")
              : Image.network(image, fit: BoxFit.cover)
          : Image.memory(
              base64Decode(
                image,
              ),
              fit: BoxFit.cover,
            ),
    ),
  );
}
