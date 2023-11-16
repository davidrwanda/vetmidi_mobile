import 'package:flutter/material.dart';

import 'colors_theme.dart';

abstract class ThemeTextStyles {
  static const heading = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: ThemeColors.primaryColor);

  static const headingBlack =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w800);

  static const secondHeadingBlack =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  static const normalText =
      TextStyle(fontSize: 15, color: ThemeColors.textColor);

  static const tileTitle = TextStyle(
    fontSize: 19,
    color: ThemeColors.textColor,
    fontWeight: FontWeight.w600,
  );

  static const tileSubTitle = TextStyle(
    fontSize: 14,
    color: ThemeColors.tertiaryTextColor,
    fontWeight: FontWeight.w600,
  );
  
  static const secondaryText = TextStyle(
    fontSize: 14,
    color: ThemeColors.tertiaryTextColor,
    fontWeight: FontWeight.w500,
  );
}
