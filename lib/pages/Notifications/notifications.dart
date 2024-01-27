import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/notifications_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/pages/Notifications/appointment_notification_card.dart';
import 'package:vetmidi/pages/Notifications/treatment_notification_card.dart';

import '../../components/back_button.dart';
import '../../controllers/auth_controller.dart';
import '../../core/utils/app_constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () async {
      String token = Get.find<AuthController>().token?.accessToken ?? "";
      if (!Get.find<NotificationController>().fetchedAppointments) {
        await Get.find<NotificationController>().getAppointments(token);
      }

      if (!Get.find<NotificationController>().fetchedTreatments) {
        await Get.find<NotificationController>().getTreatments(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.primaryBackground,
        body: Container(
          padding: EdgeInsets.all(20 * fem),
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(),
              SizedBox(height: 10 * fem),
              Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 35 * fem,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Obx(() {
                  return ListView(
                    children: [
                      ...Get.find<NotificationController>()
                          .appointments
                          .map((appointment) =>
                              AppointmentNotificationCard(notification: appointment))
                          .toList(),
                      ...Get.find<NotificationController>()
                          .treatments
                          .map((treatment) =>
                              TreatmentNotificationCard(notification: treatment))
                          .toList(),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
