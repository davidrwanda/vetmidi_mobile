import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/pages/Pets/pets_table_view.dart';
import 'package:vetmidi/routes/index.dart';

import '../../components/app_bar.dart';
import '../../components/loading.dart';
import '../../controllers/auth_controller.dart';
import '../../core/utils/app_constants.dart';
import 'patient_card.dart';

class MyPetsScreen extends StatefulWidget {
  const MyPetsScreen({super.key});

  @override
  State<MyPetsScreen> createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  @override
  void initState() {
    super.initState();

    if (!Get.find<PatientController>().fetchedPatients) {
      Future.delayed(const Duration(seconds: 0), () {
        String token = Get.find<AuthController>().token?.accessToken ?? "";
        Get.find<PatientController>().getPatients(token);
      });
    }
  }

  var activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      color: ThemeColors.primaryBackground,
      child: Column(
        children: [
          const CustomAppBar(),
          SizedBox(height: 20 * fem),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20 * fem),
            width: double.infinity,
            child: Column(children: [
              Text(
                "page.pets.Mypets".tr,
                style: TextStyle(
                  fontSize: 28 * ffem,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10 * fem),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70 * fem,
                    height: 40 * fem,
                    padding: EdgeInsets.all(2 * fem),
                    decoration: BoxDecoration(
                      color: ThemeColors.primaryGrey3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              activeTab = 0;
                            }),
                            child: Container(
                              height: double.infinity,
                              padding: EdgeInsets.all(3 * fem),
                              decoration: BoxDecoration(
                                color: activeTab == 0
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset("assets/images/grid.png"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              activeTab = 1;
                            }),
                            child: Container(
                              padding: EdgeInsets.all(3 * fem),
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: activeTab == 1
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset("assets/images/rows.png"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10 * fem),
                  Button(
                    "page.pets.addPet".tr,
                    (BuildContext ctx) async {
                      Get.toNamed(AppRoutes.addpet);
                    },
                    context,
                    hasIcon: true,
                    icon: Icons.add,
                    fontSize: 14,
                    backgroundColor: ThemeColors.secondaryColor,
                  )
                ],
              )
            ]),
          ),
          Expanded(
            child: Obx(() {
              if (!Get.find<PatientController>().loading) {
                return activeTab == 0
                    ? ListView(
                        children: [
                          SizedBox(height: 30 * fem),
                          ...Get.find<PatientController>()
                              .patients
                              .map((patient) => PatientCard(patient: patient))
                              .toList()
                        ],
                      )
                    : const PetsTableView();
              } else {
                return Container(
                  margin: EdgeInsets.fromLTRB(
                      15 * fem, 45 * fem, 15 * fem, 15 * fem),
                  padding: EdgeInsets.all(20 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10 * fem)),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50 * fem,
                        child: Image.asset("assets/images/dog.png"),
                      ),
                      SizedBox(height: 10 * fem),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.editpetdetails);
                        },
                        child: Container(
                          width: 60 * fem,
                          height: 20 * fem,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.edit_outlined,
                              color: ThemeColors.secondaryColor),
                          SizedBox(width: 3 * fem),
                          Text(
                            "page.pets.editPet".tr,
                            style: const TextStyle(
                                color: ThemeColors.secondaryColor),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 10 * fem),
                          detailsLoading(),
                          detailsLoading(),
                          detailsLoading(),
                          detailsLoading(),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
