import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/utils/app_constants.dart';

Column detailsLoading() {
  return Column(
    children: [
      const Divider(color: Colors.black12, thickness: 1),
      SizedBox(height: 6 * fem),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 20 * fem,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 3 * fem),
          color: Colors.cyan,
        ),
      ),
    ],
  );
}

Row recordsLoading() {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 20 * fem,
                      width: 30 * fem,
                      color: Colors.grey,
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 20 * fem,
                      width: 30 * fem,
                      color: Colors.grey,
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 20 * fem,
                      width: 30 * fem,
                      color: Colors.grey,
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 20 * fem,
                      width: 30 * fem,
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
  }
