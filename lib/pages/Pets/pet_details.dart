import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/core/utils/functions.dart';
import 'package:vetmidi/pages/Pets/pet_files.dart';
import 'package:vetmidi/pages/Pets/upload_documents.dart';

import '../../components/app_bar.dart';
import '../../components/inputs.dart';
import '../../components/pet_image.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';
import '../../routes/index.dart';

class PetDetailsScreen extends StatefulWidget {
  const PetDetailsScreen({super.key});

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  var activeTab = 0;

  late TextEditingController _petName;
  String? specie;
  String? spayed;
  var vaccinationDate = "";
  var identificationDate = "";
  var dateOfBirth = "";
  late TextEditingController _breed;
  late TextEditingController _color;
  var rabbiesVaccinationDate = "";
  late TextEditingController _microship;
  late TextEditingController _weight;
  String? sex;
  late TextEditingController _alimentation;
  String? goesOutside;
  String? isInsured;
  late TextEditingController _insuranceName;

  @override
  void initState() {
    super.initState();
    _petName = TextEditingController();
    _petName.text = Get.find<PatientController>().patient?.name ?? "";

    vaccinationDate =
        Get.find<PatientController>().patient?.relanceMaladies ?? "";
    identificationDate =
        Get.find<PatientController>().patient?.identificationDate ?? "";
    dateOfBirth = Get.find<PatientController>().patient?.birthDate ?? "";

    _breed = TextEditingController();
    _breed.text = Get.find<PatientController>().patient?.race ?? "";

    _color = TextEditingController();
    _color.text = Get.find<PatientController>().patient?.color ?? "";

    rabbiesVaccinationDate =
        Get.find<PatientController>().patient?.relanceRage ?? "";

    _microship = TextEditingController();
    _microship.text = Get.find<PatientController>().patient?.microship ?? "";

    _weight = TextEditingController();
    _weight.text =
        Get.find<PatientController>().patient?.weight.toString() ?? "";

    _alimentation = TextEditingController();
    _alimentation.text =
        Get.find<PatientController>().patient?.alimentation.toString() ?? "";

    _insuranceName = TextEditingController();
    _insuranceName.text =
        (Get.find<PatientController>().patient?.insuranceName ?? "").isNotEmpty
            ? Get.find<PatientController>().patient!.insuranceName
            : "N/A";
  }

  @override
  Widget build(BuildContext context) {
    specie = "page.type.${Get.find<PatientController>().patient?.species}".tr;

    spayed = getTranslationKeys(
            Get.find<PatientController>().patient?.sterilise.toLowerCase() ??
                "yes")
        .tr;
    goesOutside = getTranslationKeys(
            Get.find<PatientController>().patient?.modeDeVie.toLowerCase() ??
                "yes")
        .tr;

    isInsured = getTranslationKeys(Get.find<PatientController>()
                .patient
                ?.insuranceDesc
                .toLowerCase() ??
            "yes")
        .tr;
    sex = (Get.find<PatientController>().patient?.sex ?? "M").startsWith("M")
        ? "page.general.male".tr
        : "page.general.female".tr;
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeColors.primaryBackground,
      body: Container(
        height: Get.height,
        child: Column(
          children: [
            const CustomAppBar(),
            SizedBox(height: 20 * fem),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  SizedBox(width: 15 * fem),
                  const Icon(
                    Icons.arrow_back,
                    color: ThemeColors.secondaryColor,
                  ),
                  const Text(
                    "Back",
                    style: TextStyle(
                      color: ThemeColors.secondaryColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10 * fem),
            Expanded(
              child: ListView(
                children: [
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
                    margin: EdgeInsets.symmetric(horizontal: 20 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10 * fem)),
                    child: Column(
                      children: [
                        petImage(
                            Get.find<PatientController>().patient!.webImage,
                            false),
                        SizedBox(height: 15 * fem),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.editpetdetails);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/edit.png"),
                              SizedBox(
                                width: 3 * fem,
                              ),
                              Text(
                                "page.pets.editPet".tr,
                                style: const TextStyle(
                                  color: ThemeColors.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15 * fem),
                        Container(
                          height: 35 * fem,
                          width: 230 * fem,
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
                                    child: Center(
                                        child: Text("page.pet.files".tr)),
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
                                    child: Center(
                                        child: Text("page.pet.upload".tr)),
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
                                    _petName,
                                    label: "page.pets.RecordsPetName".tr,
                                    readOnly: true,
                                  ),
                                  select(
                                    "page.pets.Type".tr,
                                    specie,
                                    [
                                      "page.type.CT".tr,
                                      "page.type.CN".tr,
                                      "page.type.LP".tr,
                                      "page.type.GP".tr,
                                      "page.type.OI".tr,
                                      "page.type.HAM".tr,
                                      "page.type.NAC".tr,
                                      "page.type.REP".tr,
                                    ],
                                    () {},
                                    readOnly: true,
                                  ),
                                  select(
                                    "page.pets.Spayed".tr,
                                    "page.general.yes".tr,
                                    [
                                      "page.general.yes".tr,
                                      "page.general.no".tr
                                    ],
                                    () {},
                                    readOnly: true,
                                  ),
                                  datePicker(
                                    label: "page.pets.VacinationDate".tr,
                                    value: vaccinationDate,
                                    onChange: (String value) {
                                      setState(() {
                                        vaccinationDate = value;
                                      });
                                    },
                                    context: context,
                                    readOnly: true,
                                  ),
                                  datePicker(
                                    label: "page.pets.IdentificationDate".tr,
                                    value: identificationDate,
                                    onChange: (String value) {
                                      setState(() {
                                        identificationDate = value;
                                      });
                                    },
                                    context: context,
                                    readOnly: true,
                                  ),
                                  datePicker(
                                    label: "page.pets.birth".tr,
                                    value: dateOfBirth,
                                    onChange: (String value) {
                                      setState(() {
                                        dateOfBirth = value;
                                      });
                                    },
                                    context: context,
                                    readOnly: true,
                                  ),
                                  InputText(
                                    "page.pets.enterBreed".tr,
                                    _breed,
                                    readOnly: true,
                                    label: "page.pets.breed".tr,
                                  ),
                                  InputText(
                                    "page.pets.enterColor".tr,
                                    _color,
                                    readOnly: true,
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
                                      readOnly: true,
                                      context: context),
                                  InputText(
                                    "page.pets.MicroshipunAvailable".tr,
                                    _microship,
                                    label: "page.pets.Microship".tr,
                                    fontSize: 15,
                                    readOnly: true,
                                  ),
                                  InputText(
                                    "page.pets.Weight".tr,
                                    _weight,
                                    label: "page.pets.Weight".tr,
                                    readOnly: true,
                                  ),
                                  select(
                                    "page.pets.sex".tr,
                                    sex,
                                    [
                                      "page.general.male".tr,
                                      "page.general.female".tr
                                    ],
                                    (String value) {
                                      setState(() {
                                        sex = value;
                                      });
                                    },
                                    errorText: "page.pets.sexIsrequired".tr,
                                    readOnly: true,
                                  ),
                                  InputText(
                                    "page.pets.Alimentation".tr,
                                    _alimentation,
                                    label: "page.pets.Alimentation".tr,
                                    readOnly: true,
                                  ),
                                  select(
                                    "page.pets.Goesoutside".tr,
                                    goesOutside,
                                    [
                                      "page.general.yes".tr,
                                      "page.general.no".tr
                                    ],
                                    (String value) {
                                      setState(() {
                                        goesOutside = value;
                                      });
                                    },
                                    readOnly: true,
                                  ),
                                  select(
                                    "page.pets.IsInsured".tr,
                                    isInsured,
                                    [
                                      "page.general.yes".tr,
                                      "page.general.no".tr
                                    ],
                                    (String value) {
                                      setState(() {
                                        isInsured = value;
                                      });
                                    },
                                    readOnly: true,
                                  ),
                                  InputText(
                                    "page.pets.Insurancename".tr,
                                    _insuranceName,
                                    label: "page.pets.Alimentation".tr,
                                    readOnly: true,
                                  ),
                                ],
                              )
                            : Container(),
                        activeTab == 1 ? const PetFiles() : Container(),
                        activeTab == 2 ? const UploadDocuments() : Container()
                      ],
                    ),
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
