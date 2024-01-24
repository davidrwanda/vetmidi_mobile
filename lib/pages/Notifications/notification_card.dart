import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vetmidi/models/notification.dart';

import '../../components/button.dart';
import '../../controllers/patient_controller.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationModel notification;

  _launchDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
    // if (await canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                notification.body
                    .replaceAll("(^^^Treatment_NAME^^^)", notification.subject),
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
                        _launchDialer(notification.phone);
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
