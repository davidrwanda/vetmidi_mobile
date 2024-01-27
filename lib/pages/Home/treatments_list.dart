import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/pages/Home/treatment_card_item.dart';

import '../../controllers/notifications_controller.dart';
import '../../core/utils/app_constants.dart';
import '../../models/notification.dart';
import '../../routes/index.dart';

Widget treatmentList(List<NotificationModel> treatments) {
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
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.treatments),
            child: Text(
              "View All",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13 * ffem,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10 * fem),
      Container(
        width: double.infinity,
        height: 170 * fem,
        padding: EdgeInsets.all(10 * fem),
        margin: EdgeInsets.only(bottom: 30 * fem),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10 * fem),
          color: Colors.white,
        ),
        child: Get.find<NotificationController>().fetchingTreatments
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) =>
                    TreatmentCardItem(treatment: treatments[index]),
                itemCount: treatments.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
      ),
    ],
  );
}
