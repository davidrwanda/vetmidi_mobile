import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vetmidi/models/notification.dart';

import '../../components/button.dart';
import '../../controllers/patient_controller.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/make_call_service.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationModel notification;

  String getNotificationBody(String originalBody, String subject, String date) {
    String newBody =
        originalBody.replaceAll('(^^^Appointment_NAME^^^)', subject);
    newBody = newBody.replaceAll('(^^^Treatment_NAME^^^)', subject);
    newBody = newBody.replaceAll('^^^Treatment_STARTING_DATE^^^', date + ' ');
    newBody = newBody.replaceAll('^^^Appointment_STARTING_DATE^^^', date + ' ');
    return newBody;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10 * fem),
        Text(
          notification.created_on,
          style: TextStyle(
            fontSize: 13 * ffem,
            color: Colors.black38,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 7 * fem),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20 * fem),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10 * fem),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.airline_stops),
              SizedBox(height: 10),
              Text(
                notification.subject,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                getNotificationBody(
                    notification.body, notification.subject, notification.date),
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      "Dial Clinic",
                      (BuildContext ctx) {
                        launchDialer(notification.phone);
                      },
                      context,
                      fontSize: 14 * ffem,
                      radius: 10 * ffem,
                      backgroundColor: ThemeColors.secondaryColor,
                    ),
                  ),
                  SizedBox(width: 20 * fem),
                  Expanded(
                    child: Obx(() {
                      return Button(
                        "View Treatment",
                        (BuildContext ctx) async {
                          // await updatePatientHandler();
                        },
                        context,
                        loading: Get.find<PatientController>().loading,
                        backgroundColor: Colors.white,
                        fontSize: 14 * ffem,
                        radius: 10 * fem,
                        color: ThemeColors.secondaryColor,
                        hasBorder: true,
                      );
                    }),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
