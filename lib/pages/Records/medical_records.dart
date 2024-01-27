import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/medical_records_controller.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/pages/Records/select_typey.dart';

import '../../components/app_bar.dart';
import '../../components/loading.dart';
import '../../components/record_row_item.dart';
import '../../controllers/auth_controller.dart';
import '../../core/utils/app_constants.dart';
import '../../models/patients.dart';

class MedicalRecords extends StatefulWidget {
  const MedicalRecords({super.key});

  @override
  State<MedicalRecords> createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  var _selectedTab = 0;
  var selectedPet = "all";
  final ScrollController _scrollController = ScrollController();

  onSelectChange(int index) {
    setState(() {
      _selectedTab = index;
    });

    String query = selectedPet == "all" ? "" : selectedPet;

    String token = Get.find<AuthController>().token?.accessToken ?? "";
    if (index == 0) {
      Get.find<MedicalRecordsController>().getMedicalRecords(query, token);
    } else if (index == 1) {
      Get.find<MedicalRecordsController>().getReport(query, token);
    } else if (index == 2) {
      Get.find<MedicalRecordsController>().getVignetteReport(query, token);
    } else {
      Get.find<MedicalRecordsController>().getPjReport(query, token);
    }
  }

  onPetchanged(String? value) {
    if (value != null) {
      setState(() {
        selectedPet = value;
      });
      onSelectChange(_selectedTab);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () {
      String token = Get.find<AuthController>().token?.accessToken ?? "";
      Get.find<MedicalRecordsController>().getMedicalRecords("", token);
    });

    if (!Get.find<PatientController>().fetchedPatients) {
      Future.delayed(const Duration(seconds: 0), () {
        String token = Get.find<AuthController>().token?.accessToken ?? "";
        Get.find<PatientController>().getPatients(token);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      color: ThemeColors.primaryBackground,
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15 * fem),
              margin: EdgeInsets.symmetric(vertical: 10 * fem),
              child: Text(
                "page.pets.MyMedicalRecords".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30 * ffem,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20 * fem),
              child: SelectType(
                tabs: ["All", "REPORT", "VIGNETTE", "PJ"],
                selectedIndex: _selectedTab,
                onChange: onSelectChange,
              ),
            ),
            SizedBox(height: 20 * fem),
            Container(
              width: 150 * fem,
              height: 40 * fem,
              padding: EdgeInsets.only(left: 10 * fem),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10 * fem)),
              margin: EdgeInsets.only(left: 20 * fem),
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
            SizedBox(height: 20 * fem),
            Container(
              height: 390 * fem,
              child: RawScrollbar(
                thumbVisibility: true,
                thumbColor: ThemeColors.primaryColor,
                trackVisibility: true,
                trackColor: const Color(0xff1C2232),
                thickness: 10 * fem,
                radius: Radius.circular(20 * fem),
                interactive: true,
                controller: _scrollController,
                scrollbarOrientation: ScrollbarOrientation.bottom,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20 * fem),
                      height: 50 * fem,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        children: [
                          SizedBox(
                            width: 90 * fem,
                            height: double.infinity,
                            child: const Center(
                              child: Text(
                                "Titre",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 110 * fem,
                            height: double.infinity,
                            child: const Center(
                              child: Text(
                                "Taper",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100 * fem,
                            height: double.infinity,
                            child: const Center(
                              child: Text(
                                "Non d'animal",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120 * fem,
                            height: double.infinity,
                            child: const Center(
                              child: Text(
                                "Date",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100 * fem,
                            height: double.infinity,
                            child: const Center(
                              child: Text(
                                "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10 * fem),
                    Get.find<MedicalRecordsController>().fetching
                        ? medicalRecordsLoading()
                        : Container(),
                    !Get.find<MedicalRecordsController>().fetching &&
                            Get.find<MedicalRecordsController>().records.isEmpty
                        ? Container(
                            color: Colors.white,
                            width: double.infinity,
                            margin: EdgeInsets.all(20 * fem),
                            padding: EdgeInsets.symmetric(vertical: 15 * fem),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Aucun"),
                                Text("enregistrement"),
                              ],
                            ),
                          )
                        : Container(),
                    !Get.find<MedicalRecordsController>().fetching &&
                            Get.find<MedicalRecordsController>()
                                .records
                                .isNotEmpty
                        ? Container(
                            height: 300 * fem,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 20 * fem),
                            child: ListView(
                              children: [
                                ...Get.find<MedicalRecordsController>()
                                    .records
                                    .map(
                                      (record) => RecordRowItem(
                                        record: record,
                                      ),
                                    )
                                    .toList(),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
