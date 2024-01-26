import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/notifications_controller.dart';
import 'package:vetmidi/pages/Home/treatment_card_item.dart';

import '../../core/utils/app_constants.dart';

Container treatmentCard() {
  return Container(
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
            itemBuilder: (BuildContext context, int index) => TreatmentCardItem(
                treatment:
                    Get.find<NotificationController>().treatments[index]),
            itemCount: Get.find<NotificationController>().treatments.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
  );
}
