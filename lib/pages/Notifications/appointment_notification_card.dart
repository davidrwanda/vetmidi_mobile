import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/models/notification.dart';

import '../../components/button.dart';
import '../../controllers/patient_controller.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/make_call_service.dart';

class AppointmentNotificationCard extends StatelessWidget {
  const AppointmentNotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationModel notification;

  String getNotificationBody(
      String originalBody, String subject, String date, String name) {
    String newBody =
        originalBody.replaceAll('(^^^Appointment_NAME^^^)', subject);
    newBody = newBody.replaceAll('^^^Appointment_STARTING_DATE^^^', date + ' ');
    newBody = newBody.replaceAll('^^^PET^^^', name);
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
              Container(
                height: 20 * fem,
                width: 20 * fem,
                child: Image.asset("assets/images/appointment_icon.png"),
              ),
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
                    notification.body,
                    notification.subject,
                    notification.date,
                    Get.find<PatientController>()
                            .getPetById(notification.pet_id)
                            ?.name ??
                        "PET"),
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      "Confirm",
                      (BuildContext ctx) {
                        launchDialer(notification.phone);
                      },
                      context,
                      fontSize: 14 * ffem,
                      radius: 10 * ffem,
                      backgroundColor: ThemeColors.secondaryColor,
                      height: 50,
                    ),
                  ),
                  SizedBox(width: 15 * fem),
                  Expanded(
                    child: Obx(() {
                      return Button(
                        "Dial Clinic",
                        (BuildContext ctx) async {
                          await launchDialer(notification.phone);
                        },
                        context,
                        loading: Get.find<PatientController>().loading,
                        backgroundColor: Colors.white,
                        fontSize: 13 * ffem,
                        radius: 10 * fem,
                        color: ThemeColors.secondaryColor,
                        hasBorder: true,
                        height: 30,
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
