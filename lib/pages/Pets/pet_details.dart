import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/inputs.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';

class PetDetailsScreen extends StatefulWidget {
  const PetDetailsScreen({super.key});

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  late TextEditingController _firstName;
  var activeTab = 0;
  var rabbiesVaccinationDate = "";

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeColors.primaryBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10 * fem, horizontal: 20 * fem),
        child: ListView(
          children: [
            SizedBox(height: 10 * fem),
            GestureDetector(
              onTap: () {
                Get.toNamed(Get.previousRoute);
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_back,
                    color: ThemeColors.secondaryColor,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                      color: ThemeColors.secondaryColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10 * fem),
            Text(
              "page.pets.info".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40 * ffem,
              ),
            ),
            SizedBox(height: 10 * fem),
            Container(
              padding: EdgeInsets.all(20 * fem),
              width: double.infinity,
              height: 930 * fem,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        color: ThemeColors.secondaryColor,
                      ),
                      SizedBox(
                        width: 3 * fem,
                      ),
                      Text(
                        "page.pets.uploadImage".tr,
                        style: const TextStyle(
                          color: ThemeColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10 * fem),
                  Container(
                    height: 35 * fem,
                    width: 200 * fem,
                    padding: EdgeInsets.all(2 * fem),
                    decoration: BoxDecoration(
                      color: ThemeColors.primaryBackground,
                      borderRadius: BorderRadius.circular(13 * fem),
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
                              decoration: BoxDecoration(
                                color: activeTab == 0
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  bottomLeft: Radius.circular(13),
                                ),
                              ),
                              child: Center(
                                child: Text("page.pet.general".tr),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: 3 * fem,
                          height: double.infinity,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              activeTab = 1;
                            }),
                            child: Container(
                              color: activeTab == 1
                                  ? Colors.white
                                  : Colors.transparent,
                              child: Center(child: Text("page.pet.files".tr)),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: 3 * fem,
                          height: double.infinity,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              activeTab = 2;
                            }),
                            child: Container(
                              color: activeTab == 2
                                  ? Colors.white
                                  : Colors.transparent,
                              child: Center(child: Text("page.pet.upload".tr)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  activeTab == 0
                      ? Column(
                          children: [
                            InputText(
                              "page.pets.PetEntername".tr,
                              _firstName,
                              label: "page.pets.RecordsPetName".tr,
                            ),
                            select(
                              "page.pets.Type".tr,
                              "page.referant.select".tr,
                              ["page.referant.select".tr, "Dog", "Mamalia"],
                              () {},
                            ),
                            select(
                              "page.pets.Spayed".tr,
                              "page.general.yes".tr,
                              ["page.general.yes".tr, "page.general.no".tr],
                              () {},
                            ),
                            InputText(
                              "page.pets.enterBreed".tr,
                              _firstName,
                              label: "page.pets.breed".tr,
                            ),
                            InputText(
                              "page.pets.enterColor".tr,
                              _firstName,
                              label: "page.pets.Color".tr,
                            ),
                            datePicker(
                                label: "page.pets.RabbiesBoaster".tr,
                                value: rabbiesVaccinationDate,
                                onChange: (String value) {
                                  setState(() {
                                    rabbiesVaccinationDate = value;
                                  });
                                },
                                context: context),
                            InputText(
                              "page.pets.Weight".tr,
                              _firstName,
                              label: "page.pets.Weight".tr,
                            ),
                            InputText(
                              "page.pets.Alimentation".tr,
                              _firstName,
                              label: "page.pets.Alimentation".tr,
                            ),
                          ],
                        )
                      : Container(),
                  activeTab == 1
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 10 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xff1C2232),
                              borderRadius: BorderRadius.circular(20 * fem)),
                          child: Center(
                            child: Text(
                              "page.pet.Nofiles".tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : Container(),
                  activeTab == 2
                      ? Container(
                          height: 300 * fem,
                          padding: EdgeInsets.all(20 * fem),
                          color: ThemeColors.primaryBackground,
                          child: Text(
                            "Put your files here, they will be uploaded and sent to the clinic or browse",
                            style: TextStyle(
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
