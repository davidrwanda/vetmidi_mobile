import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vetmidi/components/back_button.dart';
import 'package:vetmidi/controllers/notifications_controller.dart';
import 'package:vetmidi/models/notification.dart';

import '../../controllers/patient_controller.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/functions.dart';
import '../../models/patients.dart';

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationModel? appointment =
        Get.find<NotificationController>().appointment;
    Patient? pet =
        Get.find<PatientController>().getPetById(appointment!.pet_id);
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeColors.primaryBackground,
      body: Padding(
        padding: EdgeInsets.all(20 * fem),
        child: Container(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(),
              SizedBox(height: 10 * fem),
              Text(
                "Appointment Details",
                style: TextStyle(
                  fontSize: 28 * ffem,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20 * fem),
              Container(
                padding: EdgeInsets.all(20 * fem),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10 * fem),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10 * fem),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text("Date")),
                          Expanded(
                            flex: 5,
                            child: Text(
                              formatDateTime(
                                appointment.created_on,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10 * fem),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text("Pet Name")),
                          Expanded(
                              flex: 5,
                              child: Row(
                                children: [
                                  Container(
                                    height: 35 * fem,
                                    width: 35 * fem,
                                    child: ClipOval(
                                      child: pet != null && pet.webImage != ""
                                          ? Image.network(pet.webImage,
                                              fit: BoxFit.cover)
                                          : Image.asset(
                                              "assets/images/dog.png"),
                                    ),
                                  ),
                                  SizedBox(width: 5 * fem),
                                  Text(pet?.name ?? ""),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10 * fem),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text("Veterinary Name")),
                          Expanded(flex: 5, child: Text("-")),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10 * fem),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text("Purpose")),
                          Expanded(flex: 5, child: Text("1162")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
