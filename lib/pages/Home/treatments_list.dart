import 'package:flutter/material.dart';
import 'package:vetmidi/pages/Home/treatment_card.dart';

import '../../core/utils/app_constants.dart';

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
          Text(
            "View All",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13 * ffem,
              color: Colors.black38,
            ),
          ),
        ],
      ),
      SizedBox(height: 10 * fem),
      treatmentCard(),
    ],
  );
}
