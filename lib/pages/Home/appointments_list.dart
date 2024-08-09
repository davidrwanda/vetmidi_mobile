import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/routes/index.dart';

import '../../controllers/notifications_controller.dart';
import '../../core/utils/app_constants.dart';
import '../../models/notification.dart';
import 'appointment_card_item.dart';

Widget appointmentList(List<NotificationModel> appointments) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "page.appointment".tr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14 * ffem,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.appointments),
            child: Text(
              "page.viewAll".tr,
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
        child: Get.find<NotificationController>().fetchingAppointments
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) =>
                    AppointmentCardItem(appointment: appointments[index]),
                itemCount: appointments.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
      ),
    ],
  );
}
