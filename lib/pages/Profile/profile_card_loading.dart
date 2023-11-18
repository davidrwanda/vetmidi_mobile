import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/app_constants.dart';
import 'details_items.dart';

class ProfileLoadingCard extends StatelessWidget {
  const ProfileLoadingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(
        20 * fem,
      ),
      margin: EdgeInsets.only(bottom: 20 * fem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100 * fem,
            width: 100 * fem,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50 * fem)),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(221, 103, 183, 1.0),
                  Color.fromRGBO(233, 101, 190, 1.0),
                  Color.fromRGBO(193, 42, 144, 1.0),
                ],
                stops: [0.0001, 0.5365, 1.0],
                // transform: GradientRotation(314.99 * 3.14159265 / 180.0),
              ),
            ),
            child: Center(
                child: Text(
              "NA",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 35 * ffem,
              ),
            )),
          ),
          SizedBox(height: 20 * fem),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100.withOpacity(0.8),
            child: Container(
              width: 250 * fem,
              height: 25 * fem,
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: 20 * fem),
          detailsItemLoading("Email"),
          detailsItemLoading("page.CityInput".tr),
          detailsItemLoading("page.PhoneInput".tr),
          detailsItemLoading("page.PostalCodeInput".tr),
          SizedBox(height: 20 * fem),
        ],
      ),
    );
  }
}
