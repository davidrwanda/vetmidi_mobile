import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/back_button.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/controllers/notifications_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/core/utils/functions.dart';

import '../../controllers/patient_controller.dart';
import '../../core/utils/app_constants.dart';
import '../../models/notification.dart';
import '../../models/patients.dart';
import '../Records/select_typey.dart';

class AppointmentsScreen extends StatefulWidget {
  AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  var _selectedTab = 0;
  var selectedPet = "all";

  onSelectChange(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  onPetchanged(String? value) {
    if (value != null) {
      setState(() {
        selectedPet = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<NotificationModel> appointments = selectedPet == 'all'
        ? Get.find<NotificationController>().appointments
        : Get.find<NotificationController>().getPetAppointments(selectedPet);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.primaryBackground,
        body: Container(
          height: Get.height,
          padding: EdgeInsets.all(20 * fem),
          child: Column(
            children: [
              backButton(),
              Text(
                "Appointments",
                style: TextStyle(
                  fontSize: 35 * ffem,
                  letterSpacing: 0.9,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20 * fem),
              Container(
                width: double.infinity,
                height: 40 * fem,
                padding: EdgeInsets.only(left: 10 * fem),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10 * fem)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: selectedPet,
                      icon: const Icon(Icons.arrow_drop_down_sharp,
                          color: ThemeColors.textColor),
                      elevation: 3,
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: ThemeColors.textColor),
                      underline: null,
                      hint: const Text("Select an option"),
                      onChanged: onPetchanged,
                      items: [
                        const DropdownMenuItem<String>(
                          value: "all",
                          child: Text(
                            "Pets: All",
                            style: TextStyle(color: ThemeColors.textColor),
                          ),
                        ),
                        ...Get.find<PatientController>()
                            .patients
                            .map<DropdownMenuItem<String>>((Patient patient) {
                          return DropdownMenuItem<String>(
                            value: patient.fmId,
                            child: Text(
                              patient.name,
                              style:
                                  const TextStyle(color: ThemeColors.textColor),
                            ),
                          );
                        }).toList(),
                      ]),
                ),
              ),
              SelectType(
                tabs: ["Upcoming", "Completed", "Cancelled"],
                selectedIndex: _selectedTab,
                onChange: onSelectChange,
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...appointments
                        .map((appointment) =>
                            AppointmentItem(appointment: appointment))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentItem extends StatelessWidget {
  const AppointmentItem({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  final NotificationModel appointment;

  @override
  Widget build(BuildContext context) {
    Patient? pet = Get.find<PatientController>().getPetById(appointment.pet_id);
    return Container(
      padding: EdgeInsets.only(bottom: 30 * fem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatDateTime(appointment.created_on),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17 * ffem),
          ),
          SizedBox(height: 10 * fem),
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
                SizedBox(height: 20),
                Button(
                  "Cancel Appointment",
                  (context) {},
                  context,
                  backgroundColor: Color(0xffE24E4E),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
