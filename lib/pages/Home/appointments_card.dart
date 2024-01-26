import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/notifications_controller.dart';
import 'package:vetmidi/pages/Home/appointment_card_item.dart';

import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';

Container appointmentCard() {
  return Container(
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
                AppointmentCardItem(
                    appointment:
                        Get.find<NotificationController>().appointments[index]),
            itemCount: Get.find<NotificationController>().appointments.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
  );
}
