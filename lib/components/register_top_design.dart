import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/app_constants.dart';

Container registerTopDesign() {
  return Container(
    height: 200 * fem,
    width: 200 * fem,
    // color: Colors.orange,
    child: Stack(
      children: [
        Positioned(
          top: 20 * fem,
          left: 10 * fem,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_left),
                SizedBox(width: 5),
                Text(
                  "Back",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 200 * fem,
            width: 170 * fem,
            child: Image.asset("assets/images/ellipse3.png"),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 160 * fem,
            width: 200 * fem,
            child: Image.asset("assets/images/ellipse4.png"),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 180 * fem,
            width: 190 * fem,
            // color: Colors.amber,
            child: Image.asset(
              "assets/images/ellipse5.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: Container(
              height: 140 * fem,
              width: 140 * fem,
              padding: EdgeInsets.only(right: 10, top: 10),
              child:
                  Image.asset("assets/images/image5.png", fit: BoxFit.contain),
            )),
      ],
    ),
  );
}
