import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/back_button.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/pages/Pets/patient_card.dart';

import '../../core/utils/app_constants.dart';
import '../Home/appointments_list.dart';
import '../Home/treatments_list.dart';

class PetProfile extends StatelessWidget {
  const PetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.primaryBackground,
        body: Padding(
          padding: EdgeInsets.all(20 * fem),
          child: Container(
            height: Get.height,
            child: ListView(
              children: [
                backButton(),
                PatientCard(patient: Get.find<PatientController>().patient!),
                appointmentList(),
                treatmentList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
