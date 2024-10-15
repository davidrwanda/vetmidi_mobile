import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vetmidi/components/back_button.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';

import '../../controllers/notifications_controller.dart';
import '../../controllers/patient_controller.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/make_call_service.dart';
import '../../models/notification.dart';
import '../../models/patients.dart';

class TreatmentDetails extends StatelessWidget {
  const TreatmentDetails({super.key});

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateFormat("MM/dd/yyyy HH:mm:ss").parse(dateTimeString);
    String locale = 'page.locale'.tr;
    if (locale == 'fr') {
      return DateFormat("d MMM yyyy '|' HH'h'mm", 'fr_FR').format(dateTime);
    } else {
      return DateFormat("MMM d, yyyy | hh:mm a").format(dateTime);
    }
  }
  @override
  Widget build(BuildContext context) {
    NotificationModel? treatment = Get.find<NotificationController>().treatment;
    Patient? pet = Get.find<PatientController>().getPetById(treatment!.pet_id);
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeColors.primaryBackground,
      body: Padding(
        padding: EdgeInsets.all(20 * fem),
        child: ListView(
          children: [
            backButton(),
            SizedBox(height: 10 * fem),
            Text(
              "page.treatmentDetails".tr,
              style: TextStyle(
                fontSize: 33 * ffem,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15 * fem),
            Container(
              padding: EdgeInsets.all(20 * fem),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10 * fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.petName".tr)),
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
                                        : Image.asset("assets/images/dog.png"),
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
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.startingDate".tr)),
                        Expanded(
                          flex: 5,
                          child: Text(
                            formatDateTime(
                              treatment.created_on,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.endingDate".tr)),
                        Expanded(
                          flex: 5,
                          child: Text(
                            treatment.date,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.renewal".tr)),
                        Expanded(flex: 5, child: Text("page.yes".tr)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  Text(
                    "page.posology1".tr,
                    style: TextStyle(
                      color: Colors.black12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10 * fem),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.medecineName".tr)),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.posology".tr)),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.instructions".tr)),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  Text(
                    "page.posology2".tr,
                    style: TextStyle(
                      color: Colors.black12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10 * fem),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.medecineName".tr)),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.posology".tr)),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("page.instructions".tr)),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  Button(
                    "page.call".tr,
                    (BuildContext ctx) {
                      launchDialer(treatment.phone);
                    },
                    context,
                    backgroundColor: Colors.white,
                    hasBorder: true,
                    color: ThemeColors.secondaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
