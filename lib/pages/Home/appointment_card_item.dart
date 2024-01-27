import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/models/notification.dart';

import '../../controllers/notifications_controller.dart';
import '../../controllers/patient_controller.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';
import '../../models/patients.dart';
import '../../routes/index.dart';

class AppointmentCardItem extends StatelessWidget {
  const AppointmentCardItem({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  final NotificationModel appointment;

  @override
  Widget build(BuildContext context) {
    Patient? pet = Get.find<PatientController>().getPetById(appointment.pet_id);
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
                    "assets/images/calendar.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8 * fem),
              Container(
                height: 20 * fem,
                width: 20 * fem,
                child: ClipOval(
                  child: pet != null && pet.webImage != ""
                      ? Image.network(pet.webImage, fit: BoxFit.cover)
                      : Image.asset("assets/images/dog.png"),
                ),
              ),
              SizedBox(width: 8 * fem),
              Text(pet?.name ?? ""),
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
                      color: Colors.black26,
                      fontSize: 11 * ffem,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    appointment.date,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10 * fem),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TIME",
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 11 * ffem,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    appointment.created_on.substring(11, 16),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  Get.find<NotificationController>().appointment = appointment;
                  Get.toNamed(AppRoutes.appointmentdetails);
                },
                child: Row(
                  children: [
                    Text("Details"),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: ThemeColors.secondaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
