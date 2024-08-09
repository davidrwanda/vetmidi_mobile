import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/core/utils/functions.dart';
import 'package:vetmidi/pages/Profile/profile_card_loading.dart';
import 'package:vetmidi/routes/index.dart';

import '../../components/app_bar.dart';
import '../../components/inputs.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../core/utils/app_constants.dart';
import 'details_items.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  String? title;
  String? country;
  String? referantDescription;
  late TextEditingController _email;
  late TextEditingController _address;
  late TextEditingController _city;
  late TextEditingController _phone;
  late TextEditingController _postalCode;
  String? contactWithEmail;
  String? contactWithSMS;
  String? contactWithWhatsapp;
  final ScrollController _scrollController = ScrollController();
  var selectedTab = 0;
  var profileChanged = false;
  var initializedFields = false;

  var fNameIsValid = true;
  var lNameIsValid = true;
  var phoneIsValid = true;
  var addressIsValid = true;
  var cityIsValid = true;
  var postalCodeIsValid = true;

  @override
  void initState() {
    super.initState();

    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _address = TextEditingController();
    _city = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _postalCode = TextEditingController();

    Future.delayed(const Duration(seconds: 0), () async {
      String token = Get.find<AuthController>().token?.accessToken ?? "";
      await Get.find<ProfileController>().getProfile(token);
      initializeFields();
    });
  }

  initializeFields() {
    _firstName.text = Get.find<ProfileController>().profile?.firstName ?? "";
    _lastName.text = Get.find<ProfileController>().profile?.lastName ?? "";
    _email.text = Get.find<ProfileController>().profile?.email ?? "";
    _address.text = Get.find<ProfileController>().profile?.address ?? "";
    _city.text = Get.find<ProfileController>().profile?.city ?? "";
    _postalCode.text = Get.find<ProfileController>().profile?.postalCode ?? "";
    _phone.text = Get.find<ProfileController>().profile?.phone ?? "";
    title = getTranslationKeys(
        Get.find<ProfileController>().profile?.title ?? "Monsieur");
    referantDescription =
        (Get.find<ProfileController>().profile?.referantDescription == "" ||
                Get.find<ProfileController>().profile?.referantDescription ==
                    null)
            ? getTranslationKeys("Recommandé par un ami")
            : getTranslationKeys(
                Get.find<ProfileController>().profile?.referantDescription ??
                    "Recommandé par un ami");
    country = getTranslationKeys(
        Get.find<ProfileController>().profile?.pays ?? "Suisse");
    contactWithEmail = getTranslationKeys(
        Get.find<ProfileController>().profile?.contactWithEmail.toLowerCase() ??
            "yes");
    contactWithSMS = getTranslationKeys(
        Get.find<ProfileController>().profile?.contactWithSMS.toLowerCase() ??
            "yes");
    contactWithWhatsapp = getTranslationKeys(Get.find<ProfileController>()
            .profile
            ?.contactWithWhatsapp
            .toLowerCase() ??
        "yes");
  }

  validateFields() {
    var formValid = true;

    if (selectedTab == 0 && _firstName.text.isEmpty) {
      formValid = false;
      setState(() {
        fNameIsValid = false;
      });
    }

    if (selectedTab == 0 && _lastName.text.isEmpty) {
      formValid = false;
      setState(() {
        lNameIsValid = false;
      });
    }

    if (selectedTab == 1 && _address.text.isEmpty) {
      formValid = false;
      setState(() {
        addressIsValid = false;
      });
    }

    if (selectedTab == 1 && _city.text.isEmpty) {
      formValid = false;
      setState(() {
        cityIsValid = false;
      });
    }

    if (selectedTab == 1 && _phone.text.isEmpty) {
      formValid = false;
      setState(() {
        phoneIsValid = false;
      });
    }

    if (selectedTab == 1 && _postalCode.text.isEmpty) {
      formValid = false;
      setState(() {
        postalCodeIsValid = false;
      });
    }

    return formValid;
  }

  updateProfileHandler() async {
    if (validateFields()) {
      Map<String, dynamic> data = {
        "first_name": _firstName.text,
        "last_name": _lastName.text,
        "email": _email.text,
        "address": _address.text,
        "pays": getCountryFrenchValue(country),
        "city": _city.text,
        "phone": _phone.text,
        "postal_code": _postalCode.text,
        "contact_with_email": getYesOrNoValue(contactWithEmail!),
        "contact_with_sms": getYesOrNoValue(contactWithSMS!),
        "contact_with_whatsapp": getYesOrNoValue(contactWithWhatsapp!),
        "title": getTitleFrenchValue(title),
        "referant_description": getReferalFrenchValue(referantDescription),
      };

      String token = Get.find<AuthController>().token?.accessToken ?? "";
      await Get.find<ProfileController>().updateProfile(data, token);
      Future.delayed(const Duration(seconds: 2), () {
        Get.find<ProfileController>().profile = null;
        Get.offAndToNamed(AppRoutes.home);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: ThemeColors.primaryBackground,
        height: Get.height,
        child: Obx(() {
          return Column(
            children: [
              const CustomAppBar(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20 * fem),
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      SizedBox(height: 25 * fem),
                      Text(
                        "sidebar.profile".tr,
                        style: TextStyle(
                          fontSize: 25 * fem,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 25 * fem,
                      ),
                      Get.find<ProfileController>().fetching
                          ? const ProfileLoadingCard()
                          : Container(),
                      !Get.find<ProfileController>().fetching
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  padding: EdgeInsets.all(
                                    20 * fem,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100 * fem,
                                        width: 100 * fem,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50 * fem)),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color.fromRGBO(
                                                  221, 103, 183, 1.0),
                                              Color.fromRGBO(
                                                  233, 101, 190, 1.0),
                                              Color.fromRGBO(193, 42, 144, 1.0),
                                            ],
                                            stops: [0.0001, 0.5365, 1.0],
                                            // transform: GradientRotation(314.99 * 3.14159265 / 180.0),
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "${Get.find<ProfileController>().profile?.firstName.substring(0, 1).toUpperCase()}${Get.find<ProfileController>().profile?.lastName.substring(0, 1).toUpperCase()}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 35 * ffem,
                                          ),
                                        )),
                                      ),
                                      SizedBox(height: 20 * fem),
                                      Text(
                                          "${Get.find<ProfileController>().profile?.firstName} ${Get.find<ProfileController>().profile?.lastName}",
                                          style:
                                              TextStyle(fontSize: 20 * ffem)),
                                      SizedBox(height: 20 * fem),
                                      detailsItem(
                                          "Email",
                                          Get.find<ProfileController>()
                                                  .profile
                                                  ?.email ??
                                              ""),
                                      detailsItem(
                                          "page.CityInput".tr,
                                          Get.find<ProfileController>()
                                                  .profile
                                                  ?.city ??
                                              ""),
                                      detailsItem(
                                          "page.PhoneInput".tr,
                                          Get.find<ProfileController>()
                                                  .profile
                                                  ?.phone ??
                                              ""),
                                      detailsItem(
                                          "page.PostalCodeInput".tr,
                                          Get.find<ProfileController>()
                                                  .profile
                                                  ?.postalCode ??
                                              ""),
                                      SizedBox(height: 20 * fem),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30 * fem),
                                Text("page.contact_with".tr),
                                SizedBox(height: 20 * fem),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(20 * fem),
                                  child: Column(children: [
                                    detailsBoolean(
                                        "Email",
                                        Get.find<ProfileController>()
                                                .profile
                                                ?.contactWithEmail
                                                .toLowerCase() ??
                                            "yes"),
                                    detailsBoolean(
                                        "SMS",
                                        Get.find<ProfileController>()
                                                .profile
                                                ?.contactWithSMS
                                                .toLowerCase() ??
                                            "yes"),
                                    detailsBoolean(
                                        "Whatsapp",
                                        Get.find<ProfileController>()
                                                .profile
                                                ?.contactWithWhatsapp
                                                .toLowerCase() ??
                                            "yes"),
                                  ]),
                                ),
                                SizedBox(height: 30 * fem),
                                Container(
                                  width: double.infinity,
                                  height: 40 * fem,
                                  padding: EdgeInsets.only(left: 10 * fem),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10 * fem)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int>(
                                        value: selectedTab,
                                        icon: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: ThemeColors.textColor),
                                        elevation: 3,
                                        dropdownColor: Colors.white,
                                        style: const TextStyle(
                                            color: ThemeColors.textColor),
                                        underline: null,
                                        hint: const Text("Select an option"),
                                        onChanged: (int? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              selectedTab = newValue;
                                            });
                                          }
                                        },
                                        items: [
                                          DropdownMenuItem<int>(
                                            value: 0,
                                            child: Text(
                                              "page.profile.pinfo".tr,
                                              style: TextStyle(
                                                  color: ThemeColors.textColor),
                                            ),
                                          ),
                                          DropdownMenuItem<int>(
                                            value: 1,
                                            child: Text(
                                              "page.AddressInput".tr,
                                              style: TextStyle(
                                                  color: ThemeColors.textColor),
                                            ),
                                          ),
                                          DropdownMenuItem<int>(
                                            value: 2,
                                            child: Text(
                                              "page.profile.contactwith".tr,
                                              style: TextStyle(
                                                  color: ThemeColors.textColor),
                                            ),
                                          ),
                                          DropdownMenuItem<int>(
                                            value: 3,
                                            child: Text(
                                              "page.referant.description".tr,
                                              style: TextStyle(
                                                  color: ThemeColors.textColor),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                SizedBox(height: 30 * fem),
                                // SizedBox(
                                //   height: 40 * fem,
                                //   width: double.infinity,
                                //   child: ListView(
                                //     scrollDirection: Axis.horizontal,
                                //     children: [
                                //       GestureDetector(
                                //         onTap: () {
                                //           _scrollController.animateTo(730 * fem,
                                //               duration:
                                //                   const Duration(seconds: 1),
                                //               curve: Curves.easeInOut);
                                //         },
                                //         child: Text(
                                //           "page.profile.pinfo".tr,
                                //           style: const TextStyle(fontSize: 13),
                                //         ),
                                //       ),
                                //       SizedBox(width: 10 * fem),
                                //       GestureDetector(
                                //         onTap: () {
                                //           _scrollController.animateTo(
                                //               1300 * fem,
                                //               duration:
                                //                   const Duration(seconds: 1),
                                //               curve: Curves.easeInOut);
                                //         },
                                //         child: Text(
                                //           "page.AddressInput".tr,
                                //           style: const TextStyle(fontSize: 13),
                                //         ),
                                //       ),
                                //       SizedBox(width: 10 * fem),
                                //       GestureDetector(
                                //         onTap: () {
                                //           _scrollController.animateTo(
                                //               1700 * fem,
                                //               duration:
                                //                   const Duration(seconds: 1),
                                //               curve: Curves.easeInOut);
                                //         },
                                //         child: Text(
                                //           "page.profile.contactwith".tr,
                                //           style: const TextStyle(fontSize: 13),
                                //         ),
                                //       ),
                                //       SizedBox(width: 10 * fem),
                                //       GestureDetector(
                                //         onTap: () {
                                //           _scrollController.animateTo(
                                //               1700 * fem,
                                //               duration:
                                //                   const Duration(seconds: 1),
                                //               curve: Curves.easeInOut);
                                //         },
                                //         child: Text(
                                //           "page.referant.description".tr,
                                //           style: const TextStyle(fontSize: 13),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                selectedTab == 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "page.profile.pinfo".tr,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(height: 20 * fem),
                                          Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(20 * fem),
                                            child: Column(
                                              children: [
                                                InputText(
                                                  "page.signUpLastNamePlaceholder"
                                                      .tr,
                                                  _firstName,
                                                  label:
                                                      "page.LastNameInput".tr,
                                                  required: true,
                                                  valid: fNameIsValid,
                                                  errorText:
                                                      "validation.signUp.required.LastName"
                                                          .tr,
                                                  setValid: (bool value) {
                                                    setState(() {
                                                      fNameIsValid = value;
                                                    });
                                                  },
                                                  setChanged: () {
                                                    setState(() {
                                                      profileChanged = true;
                                                    });
                                                  },
                                                  changed: profileChanged,
                                                ),
                                                InputText(
                                                  "",
                                                  _lastName,
                                                  label:
                                                      "page.FirstNameInput".tr,
                                                  required: true,
                                                  valid: lNameIsValid,
                                                  errorText:
                                                      "validation.signUp.required.FirstName"
                                                          .tr,
                                                  setValid: (bool value) {
                                                    setState(() {
                                                      profileChanged = true;
                                                      lNameIsValid = value;
                                                    });
                                                  },
                                                  setChanged: () {
                                                    setState(() {
                                                      profileChanged = true;
                                                    });
                                                  },
                                                  changed: profileChanged,
                                                ),
                                                // select(
                                                //   "page.title".tr,
                                                //   title,
                                                //   [
                                                //     "page.title",
                                                //     "page.general.madame",
                                                //     "page.general.monsieur",
                                                //     "page.general.mademoiselle",
                                                //   ],
                                                //   (String value) {
                                                //     print("valueee $value");
                                                //     setState(() {
                                                //       title = value;
                                                //     });
                                                //   },
                                                //   required: true,
                                                // ),
                                                select(
                                                  "page.country".tr,
                                                  country,
                                                  [
                                                    "page.general.suisse",
                                                    "page.general.france",
                                                    "page.general.Italie",
                                                    "page.general.Allemagne",
                                                  ],
                                                  (String value) {
                                                    setState(() {
                                                      profileChanged = true;
                                                      country = value;
                                                    });
                                                  },
                                                  required: true,
                                                ),
                                                InputText(
                                                  "",
                                                  _email,
                                                  label: "Email",
                                                  readOnly: true,
                                                  required: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                selectedTab == 1
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "page.AddressInput".tr,
                                            style:
                                                TextStyle(fontSize: 25 * ffem),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(20 * fem),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20 * fem),
                                            child: Column(children: [
                                              InputText(
                                                "page.signUpAddressPlaceholder"
                                                    .tr,
                                                _address,
                                                label: "page.AddressInput".tr,
                                                required: true,
                                                valid: addressIsValid,
                                                errorText:
                                                    "errors.form.address.required"
                                                        .tr,
                                                setValid: (bool value) {
                                                  setState(() {
                                                    profileChanged = true;
                                                    addressIsValid = value;
                                                  });
                                                },
                                                setChanged: () {
                                                  setState(() {
                                                    profileChanged = true;
                                                  });
                                                },
                                                changed: profileChanged,
                                              ),
                                              InputText(
                                                "page.signUpCityPlaceholder".tr,
                                                _city,
                                                label: "page.CityInput".tr,
                                                errorText:
                                                    "errors.form.city.required"
                                                        .tr,
                                                valid: cityIsValid,
                                                setValid: (bool value) {
                                                  setState(() {
                                                    profileChanged = true;
                                                    cityIsValid = value;
                                                  });
                                                },
                                                setChanged: () {
                                                  setState(() {
                                                    profileChanged = true;
                                                  });
                                                },
                                                changed: profileChanged,
                                                required: true,
                                              ),
                                              InputText(
                                                "page.signUpPhonePlaceholder"
                                                    .tr,
                                                _phone,
                                                label: "page.PhoneInput".tr,
                                                errorText:
                                                    "validation.signUp.required.Phone"
                                                        .tr,
                                                valid: phoneIsValid,
                                                required: true,
                                                setValid: (bool value) {
                                                  setState(() {
                                                    profileChanged = true;
                                                    phoneIsValid = value;
                                                  });
                                                },
                                                setChanged: () {
                                                  setState(() {
                                                    profileChanged = true;
                                                  });
                                                },
                                                changed: profileChanged,
                                              ),
                                              InputText(
                                                "page.signUpPostalCodePlaceholder"
                                                    .tr,
                                                _postalCode,
                                                label:
                                                    "page.PostalCodeInput".tr,
                                                errorText:
                                                    "errors.form.postalCode.required"
                                                        .tr,
                                                valid: postalCodeIsValid,
                                                setValid: (bool value) {
                                                  setState(() {
                                                    profileChanged = true;
                                                    postalCodeIsValid = value;
                                                  });
                                                },
                                                setChanged: () {
                                                  setState(() {
                                                    profileChanged = true;
                                                  });
                                                },
                                                changed: profileChanged,
                                                required: true,
                                              ),
                                            ]),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                selectedTab == 2
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "page.contact_with".tr,
                                            style:
                                                TextStyle(fontSize: 25 * ffem),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(20 * fem),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20 * fem),
                                            child: Column(children: [
                                              select(
                                                "page.contact_with_email".tr,
                                                contactWithEmail,
                                                [
                                                  "page.general.yes",
                                                  "page.general.no"
                                                ],
                                                (String value) {
                                                  setState(() {
                                                    profileChanged = true;
                                                    contactWithEmail = value;
                                                  });
                                                },
                                                required: true,
                                              ),
                                              select(
                                                "page.contact_with_sms".tr,
                                                contactWithSMS,
                                                [
                                                  "page.general.yes",
                                                  "page.general.no"
                                                ],
                                                (String value) {
                                                  setState(() {
                                                    profileChanged = true;
                                                    contactWithSMS = value;
                                                  });
                                                },
                                                required: true,
                                              ),
                                              select(
                                                "page.contact_with_whatsapp".tr,
                                                contactWithWhatsapp,
                                                [
                                                  "page.general.yes",
                                                  "page.general.no"
                                                ],
                                                (String value) {
                                                  setState(() {
                                                    profileChanged = true;
                                                    contactWithWhatsapp = value;
                                                  });
                                                },
                                                required: true,
                                              ),
                                            ]),
                                          ),
                                        ],
                                      )
                                    : Container(),

                                selectedTab == 3
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "page.referant.description".tr,
                                            style:
                                                TextStyle(fontSize: 25 * ffem),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(20 * fem),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20 * fem),
                                            child: Column(children: [
                                              select(
                                                "page.referant.description".tr,
                                                referantDescription,
                                                [
                                                  "page.referant.byfriend",
                                                  "page.referant.bygads",
                                                  "page.referant.bylocal",
                                                  "page.referant.byvet1",
                                                  "page.referant.byfbc",
                                                  "page.referant.byvt2",
                                                ],
                                                (String value) {
                                                  setState(() {
                                                    profileChanged = true;
                                                    referantDescription = value;
                                                  });
                                                },
                                                required: true,
                                              )
                                            ]),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              !Get.find<ProfileController>().fetching
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 5 * fem),
                      margin: EdgeInsets.symmetric(horizontal: 10 * fem),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Obx(() {
                              return Button(
                                "page.profile.saveChanges.btn".tr,
                                (BuildContext ctx) async {
                                  if (profileChanged) {
                                    await updateProfileHandler();
                                  }
                                },
                                context,
                                loading: Get.find<ProfileController>().updating,
                                color: !profileChanged
                                    ? ThemeColors.secondaryColor
                                    : Colors.white,
                                backgroundColor: !profileChanged
                                    ? Colors.transparent
                                    : Colors.blue,
                                hasBorder: !profileChanged ? true : false,
                                fontSize: 12 * ffem,
                                weight: FontWeight.w800,
                              );
                            }),
                          ),
                          SizedBox(width: 10 * fem),
                          Expanded(
                            flex: 6,
                            child: Button(
                              "page.profile.changePassword.btn".tr,
                              (BuildContext ctx) {
                                Get.toNamed(AppRoutes.changePassword);
                              },
                              context,
                              color: ThemeColors.secondaryColor,
                              backgroundColor: Colors.transparent,
                              hasBorder: true,
                              fontSize: 12 * ffem,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
        }),
      ),
    );
  }
}
