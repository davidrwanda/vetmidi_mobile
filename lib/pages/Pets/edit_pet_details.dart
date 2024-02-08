import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vetmidi/components/pet_image.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/core/utils/functions.dart';
import 'package:vetmidi/core/utils/pick_image.dart';

import '../../components/app_bar.dart';
import '../../components/button.dart';
import '../../components/inputs.dart';
import '../../controllers/auth_controller.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';
import 'pet_files.dart';
import 'upload_documents.dart';

class EditPetDetailsScreen extends StatefulWidget {
  const EditPetDetailsScreen({super.key});

  @override
  State<EditPetDetailsScreen> createState() => _EditPetDetailsScreenState();
}

class _EditPetDetailsScreenState extends State<EditPetDetailsScreen> {
  var activeTab = 0;
  String? image;

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

  var nameIsValid = true;
  var specieIsValid = true;
  var spayedIsValid = true;
  var dobIsValid = true;
  var breedIsValid = true;
  var weightIsValid = true;
  var sexIsValid = true;
  var insuredIsValid = true;

  setImage(String imageTemporary) {
    setState(() {
      image = imageTemporary;
    });
  }

  initiateFields() {
    _petName.text = Get.find<PatientController>().patient?.name ?? "";
    specie = "page.type.${Get.find<PatientController>().patient?.species}";
    spayed = getTranslationKeys(
        Get.find<PatientController>().patient?.sterilise.toLowerCase() ??
            "yes");
    vaccinationDate =
        Get.find<PatientController>().patient?.relanceMaladies ?? "";
    identificationDate =
        Get.find<PatientController>().patient?.identificationDate ?? "";
    dateOfBirth = Get.find<PatientController>().patient?.birthDate ?? "";
    _breed.text = Get.find<PatientController>().patient?.race ?? "";
    _color.text = Get.find<PatientController>().patient?.color ?? "";
    rabbiesVaccinationDate =
        Get.find<PatientController>().patient?.relanceRage ?? "";
    _microship.text = Get.find<PatientController>().patient?.microship ?? "";
    _weight.text =
        Get.find<PatientController>().patient?.weight.toString() ?? "";
    sex = (Get.find<PatientController>().patient?.sex ?? "M").startsWith("M")
        ? "page.general.male"
        : "page.general.female";
    _alimentation.text =
        Get.find<PatientController>().patient?.alimentation.toString() ?? "";
    goesOutside = getTranslationKeys(
        Get.find<PatientController>().patient?.modeDeVie.toLowerCase() ??
            "yes");
    isInsured = getTranslationKeys(
        Get.find<PatientController>().patient?.insuranceDesc.toLowerCase() ??
            "yes");
    _insuranceName.text =
        (Get.find<PatientController>().patient?.insuranceName ?? "").isNotEmpty
            ? Get.find<PatientController>().patient!.insuranceName
            : "N/A";
  }

  @override
  void initState() {
    super.initState();
    _petName = TextEditingController();
    _breed = TextEditingController();
    _color = TextEditingController();
    _microship = TextEditingController();
    _weight = TextEditingController();
    _alimentation = TextEditingController();
    _insuranceName = TextEditingController();

    initiateFields();

    Future.delayed(const Duration(seconds: 0), () {
      String token = Get.find<AuthController>().token?.accessToken ?? "";
      Get.find<PatientController>()
          .getPetFiles(Get.find<PatientController>().patient!.fmId, token);
    });
  }

  validateFields() {
    var formValid = true;

    if (_petName.text.isEmpty) {
      formValid = false;
      setState(() {
        nameIsValid = false;
      });
    }

    if (specie == null || specie == "no_value") {
      formValid = false;
      setState(() {
        specieIsValid = false;
      });
    }

    if (spayed == null || spayed == "no_value") {
      formValid = false;
      setState(() {
        spayedIsValid = false;
      });
    }

    if (sex == null || sex == "no_value") {
      formValid = false;
      setState(() {
        sexIsValid = false;
      });
    }

    if (isInsured == null || isInsured == "no_value") {
      formValid = false;
      setState(() {
        insuredIsValid = false;
      });
    }

    if (dateOfBirth.isEmpty) {
      formValid = false;
      setState(() {
        dobIsValid = false;
      });
    }

    if (_breed.text.isEmpty) {
      formValid = false;
      setState(() {
        breedIsValid = false;
      });
    }

    if (_weight.text.isEmpty) {
      formValid = false;
      setState(() {
        weightIsValid = false;
      });
    }

    return formValid;
  }

  updatePatientHandler() async {
    if (validateFields()) {
      Map<String, dynamic> data = {
        "name": _petName.text,
        "species": specie!.split('.')[2],
        "sterilise": getYesOrNoValue(spayed!),
        "relance_maladies": vaccinationDate,
        "identification_date": identificationDate,
        "birth_date": dateOfBirth,
        "race": _breed.text,
        "color": _color.text,
        "relance_rage": rabbiesVaccinationDate,
        "weight": int.parse(_weight.text),
        "sex": sex!.tr.substring(0, 1),
        "alimentation": _alimentation.text,
        "mode_de_vie": getYesOrNoValue(goesOutside!),
        "insurance_desc": getYesOrNoValue(isInsured!),
      };
      if (image != null) {
        data['photo'] = image;
      } else {
        data['photo'] = Get.find<PatientController>().patient!.webImage;
      }

      String token = Get.find<AuthController>().token?.accessToken ?? "";
      await Get.find<PatientController>().updatePatient(
          Get.find<PatientController>().patient!.fmId, data, token);
      // Get.find<AuthController>().selectedTab = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeColors.primaryBackground,
      body: ListView(
        children: [
          const CustomAppBar(),
          SizedBox(height: 20 * fem),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Row(
              children: [
                Icon(
                  Icons.chevron_left,
                  size: 26 * ffem,
                ),
                Text(
                  "Back",
                  style: TextStyle(fontSize: 17 * ffem),
                )
              ],
            ),
          ),
          SizedBox(height: 10 * fem),
          Text(
            "page.pets.editPet".tr,
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
                image == null
                    ? petImage(
                        Get.find<PatientController>().patient!.webImage, false)
                    : petImage(image!, true),
                SizedBox(height: 15 * fem),
                GestureDetector(
                  onTap: () async {
                    await pickImage(ImageSource.gallery, setImage);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: ThemeColors.secondaryColor),
                      SizedBox(
                        width: 3 * fem,
                      ),
                      Text(
                        "page.pets.editImage".tr,
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
                  width: 250 * fem,
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
                            _petName,
                            label: "page.pets.RecordsPetName".tr,
                            required: true,
                            valid: nameIsValid,
                            errorText: "page.pets.nameIsrequired".tr,
                            setValid: (bool value) {
                              setState(() {
                                nameIsValid = value;
                              });
                            },
                          ),
                          select(
                            "page.pets.Type".tr,
                            specie,
                            [
                              "page.type.CT",
                              "page.type.CN",
                              "page.type.LP",
                              "page.type.GP",
                              "page.type.OI",
                              "page.type.HAM",
                              "page.type.NAC",
                              "page.type.REP",
                            ],
                            required: true,
                            valid: specieIsValid,
                            errorText: "page.pets.typeIsrequired".tr,
                            (String value) {
                              setState(() {
                                specie = value;
                                specieIsValid = true;
                              });
                            },
                          ),
                          select(
                            "page.pets.Spayed".tr,
                            spayed,
                            ["page.general.yes", "page.general.no"],
                            (String value) {
                              setState(() {
                                spayed = value;
                                spayedIsValid = true;
                              });
                            },
                            required: true,
                            valid: spayedIsValid,
                            errorText: "page.pets.SpayedValidate".tr,
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
                          ),
                          datePicker(
                            label: "page.pets.birth".tr,
                            value: dateOfBirth,
                            onChange: (String value) {
                              setState(() {
                                dateOfBirth = value;
                              });
                            },
                            required: true,
                            valid: dobIsValid,
                            context: context,
                          ),
                          InputText(
                            "page.pets.enterBreed".tr,
                            _breed,
                            label: "page.pets.breed".tr,
                            required: true,
                            valid: breedIsValid,
                            errorText: "page.pets.breedIsrequired".tr,
                            setValid: (bool value) {
                              setState(() {
                                breedIsValid = value;
                              });
                            },
                          ),
                          InputText(
                            "page.pets.enterColor".tr,
                            _color,
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
                            "page.pets.MicroshipunAvailable".tr,
                            _microship,
                            label: "page.pets.Microship".tr,
                            readOnly: true,
                            fontSize: 15,
                          ),
                          InputText(
                            "page.pets.Weight".tr,
                            _weight,
                            label: "page.pets.Weight".tr,
                            required: true,
                            valid: weightIsValid,
                            errorText: "page.pets.WeightValidation".tr,
                            setValid: (bool value) {
                              setState(() {
                                weightIsValid = value;
                              });
                            },
                          ),
                          select(
                            "page.pets.sex".tr,
                            sex,
                            ["page.general.male", "page.general.female"],
                            (String value) {
                              setState(() {
                                sex = value;
                                sexIsValid = true;
                              });
                            },
                            required: true,
                            valid: sexIsValid,
                            errorText: "page.pets.sexIsrequired".tr,
                          ),
                          InputText(
                            "page.pets.Alimentation".tr,
                            _alimentation,
                            label: "page.pets.Alimentation".tr,
                          ),
                          select(
                            "page.pets.Goesoutside".tr,
                            goesOutside,
                            ["page.general.yes", "page.general.no"],
                            (String value) {
                              setState(() {
                                goesOutside = value;
                              });
                            },
                          ),
                          select(
                            "page.pets.IsInsured".tr,
                            isInsured,
                            ["page.general.yes", "page.general.no"],
                            (String value) {
                              setState(() {
                                isInsured = value;
                                insuredIsValid = true;
                              });
                            },
                            valid: insuredIsValid,
                            errorText: "page.pets.IsInsuredvalidate".tr,
                            required: true,
                          ),
                          InputText(
                            "page.pets.Insurancename".tr,
                            _insuranceName,
                            label: "page.pets.Alimentation".tr,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Button(
                                  "page.pet.cancel".tr,
                                  (BuildContext ctx) {
                                    Get.back();
                                  },
                                  context,
                                  backgroundColor: Colors.white,
                                  color: ThemeColors.secondaryColor,
                                  hasBorder: true,
                                ),
                              ),
                              SizedBox(width: 20 * fem),
                              Expanded(
                                child: Obx(() {
                                  return Button(
                                    "page.pet.save".tr,
                                    (BuildContext ctx) async {
                                      await updatePatientHandler();
                                    },
                                    context,
                                    loading:
                                        Get.find<PatientController>().loading,
                                    backgroundColor: ThemeColors.secondaryColor,
                                  );
                                }),
                              ),
                            ],
                          )
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
    ));
  }
}
