import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/back_button.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';

import '../../controllers/patient_controller.dart';
import '../../core/utils/app_constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.primaryBackground,
        body: Container(
          height: Get.height,
          padding: EdgeInsets.all(20 * fem),
          child: ListView(
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
                      onChanged: (String? newValue) {},
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
                            value: patient.name,
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
              Text(
                "Sep, 12, 2023 | 12:30 PM",
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 17 * ffem),
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
                                      child: Image.asset(
                                        "assets/images/luna.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5 * fem),
                                  Text("Luna"),
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
              SizedBox(height: 30),
              Text(
                "Sep, 12, 2023 | 12:30 PM",
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 17 * ffem),
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
                                      child: Image.asset(
                                        "assets/images/luna.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5 * fem),
                                  Text("Luna"),
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
        ),
      ),
    );
  }
}
