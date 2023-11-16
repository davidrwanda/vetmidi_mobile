import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/core/utils/functions.dart';

import '../../components/app_bar.dart';
import '../../components/inputs.dart';
import '../../core/utils/app_constants.dart';

class NewPet extends StatefulWidget {
  const NewPet({super.key});

  @override
  State<NewPet> createState() => _NewPetState();
}

class _NewPetState extends State<NewPet> {
  late TextEditingController _petName;
  String? specie;
  String? spayed;
  var vaccinationDate = "";
  var identificationDate = "";
  var dateOfBirth = "";
  late TextEditingController _breed;
  late TextEditingController _color;
  var rabbiesVaccinationDate = "";
  late TextEditingController _weight;
  String? sex;
  late TextEditingController _alimentation;
  String? goesOutside;
  String? isInsured;

  var nameIsValid = true;
  var specieIsValid = true;
  var spayedIsValid = true;
  var dobIsValid = true;
  var breedIsValid = true;
  var weightIsValid = true;
  var sexIsValid = true;
  var insuredIsValid = true;

  @override
  void initState() {
    super.initState();
    _petName = TextEditingController();
    _breed = TextEditingController();
    _color = TextEditingController();
    _weight = TextEditingController();
    _alimentation = TextEditingController();
  }

  validateFields() {
    var formValid = true;

    print("date of birth  $dateOfBirth");
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

  addPetHandler() async {
    if (validateFields()) {
      Map<String, dynamic> data = {
        "name": _petName.text,
        "species": getTranslationKeys(specie!).split('.')[2],
        "sterilise": getYesOrNoValue(spayed!),
        "relance_maladies": vaccinationDate,
        "identification_date": identificationDate,
        "birth_date": dateOfBirth,
        "race": _breed.text,
        "color": _color.text,
        "relance_rage": rabbiesVaccinationDate,
        "weight": int.parse(_weight.text),
        "sex": sex!.substring(0, 1),
        "alimentation": _alimentation.text,
        "mode_de_vie": getYesOrNoValue(goesOutside!),
        "insurance_desc": getYesOrNoValue(isInsured!),
      };

      print("sent dataaaaaaaaaaaaaaaaaaaaaaa//\\ $data");
      // String token = Get.find<AuthController>().token?.accessToken ?? "";
      // await Get.find<PatientController>().createPatient(data, token);
      // print("doneeeeeeeeeee");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Get.height,
        color: ThemeColors.primaryBackground,
        child: ListView(
          children: [
            const CustomAppBar(),
            SizedBox(height: 20 * fem),
            Text(
              "page.pets.addPet".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40 * ffem,
              ),
            ),
            SizedBox(height: 10 * fem),
            Container(
              margin: EdgeInsets.all(15 * fem),
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
                          child: Container(
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(13),
                                bottomLeft: Radius.circular(13),
                              ),
                            ),
                            child: Center(
                              child: Text("page.pet.general".tr),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Center(child: Text("page.pet.upload".tr)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  InputText(
                    "page.pets.PetEntername".tr,
                    _petName,
                    valid: nameIsValid,
                    errorText: "page.pets.nameIsrequired".tr,
                    label: "page.pets.RecordsPetName".tr,
                    required: true,
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
                      "page.type.CT".tr,
                      "page.type.CN".tr,
                      "page.type.LP".tr,
                      "page.type.GP".tr,
                      "page.type.OI".tr,
                      "page.type.HAM".tr,
                      "page.type.NAC".tr,
                      "page.type.REP".tr,
                    ],
                    (String value) {
                      print("Yes changedddddddddddddd $value");
                      setState(() {
                        specie = value;
                        specieIsValid = true;
                      });
                    },
                    valid: specieIsValid,
                    errorText: "page.pets.typeIsrequired".tr,
                    required: true,
                  ),
                  select(
                    "page.pets.Spayed".tr,
                    spayed,
                    ["page.general.yes".tr, "page.general.no".tr],
                    (String value) {
                      setState(() {
                        spayed = value;
                        spayedIsValid = true;
                      });
                    },
                    valid: spayedIsValid,
                    errorText: "page.pets.SpayedValidate".tr,
                    required: true,
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
                        dobIsValid = true;
                      });
                    },
                    required: true,
                    valid: dobIsValid,
                    errorText: "page.pets.bdateIsrequired".tr,
                    context: context,
                  ),
                  InputText(
                    "page.pets.enterBreed".tr,
                    _breed,
                    label: "page.pets.breed".tr,
                    valid: breedIsValid,
                    errorText: "page.pets.breedIsrequired".tr,
                    required: true,
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
                    context: context,
                  ),
                  InputText(
                    "page.pets.Weight".tr,
                    _weight,
                    label: "page.pets.Weight".tr,
                    valid: weightIsValid,
                    errorText: "page.pets.WeightValidation".tr,
                    required: true,
                    setValid: (bool value) {
                      setState(() {
                        weightIsValid = value;
                      });
                    },
                  ),
                  select("page.pets.sex".tr, sex, [
                    "page.general.male".tr,
                    "page.general.female".tr
                  ], (String value) {
                    setState(() {
                      sex = value;
                      sexIsValid = true;
                    });
                  },
                      required: true,
                      valid: sexIsValid,
                      errorText: "page.pets.sexIsrequired".tr),
                  InputText(
                    "page.pets.Alimentation".tr,
                    _alimentation,
                    label: "page.pets.Alimentation".tr,
                  ),
                  select(
                    "page.pets.Goesoutside".tr,
                    goesOutside,
                    ["page.general.yes".tr, "page.general.no".tr],
                    (String value) {
                      setState(() {
                        goesOutside = value;
                      });
                    },
                  ),
                  select(
                    "page.pets.IsInsured".tr,
                    isInsured,
                    ["page.general.yes".tr, "page.general.no".tr],
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
                  Row(
                    children: [
                      Expanded(
                        child: Button(
                          "page.pet.cancel".tr,
                          (BuildContext ctx) {},
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
                              await addPetHandler();
                            },
                            context,
                            loading: Get.find<PatientController>().loading,
                            backgroundColor: ThemeColors.secondaryColor,
                          );
                        }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
