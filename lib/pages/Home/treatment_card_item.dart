import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vetmidi/controllers/notifications_controller.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/models/notification.dart';

import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';

class TreatmentCardItem extends StatelessWidget {
  const TreatmentCardItem({
    Key? key,
    required this.treatment,
  }) : super(key: key);

  final NotificationModel treatment;

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateFormat("MM/dd/yyyy HH:mm:ss").parse(dateTimeString);
    return DateFormat("MMM, d, yyyy | hh:mm a").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 15 * fem,
                width: 15 * fem,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/pill.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8 * fem),
              Container(
                height: 20 * fem,
                width: 20 * fem,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/luna.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8 * fem),
              Text(Get.find<PatientController>()
                      .getPetById(treatment.pet_id)
                      ?.name ??
                  ""),
            ],
          ),
          SizedBox(height: 9 * fem),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DATE",
                    style: TextStyle(
                      color: Colors.black12,
                      fontSize: 11 * ffem,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    formatDateTime(treatment.created_on),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13 * ffem,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10 * fem),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "END DAY",
                    style: TextStyle(
                      color: Colors.black12,
                      fontSize: 11 * ffem,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    treatment.date,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13 * ffem,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Text("Details"),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: ThemeColors.secondaryColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
