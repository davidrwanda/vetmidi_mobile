import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/core/utils/functions.dart';
import 'package:vetmidi/core/utils/toast.dart';
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
  var formValid = true;

  var fNameIsValid = true;
  var lNameIsValid = true;
  var phoneIsValid = true;
  var addressIsValid = true;
  var cityIsValid = true;
  var postalCodeIsValid = true;

  String? clinicId;
  String? clinicName;
  String? clinicAddress;
  String? clinicPhone;
  List<Map<String, dynamic>> clinicOptions = [];
  String? currentClinicId;

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

    _phone.addListener(() {
      String phoneNumber = _phone.text;
      bool isValid = validatePhoneNumber(phoneNumber);
      setState(() {
        phoneIsValid = isValid;
      });
    });
    
    Future.delayed(const Duration(seconds: 0), () async {
      String token = Get.find<AuthController>().token?.accessToken ?? "";
      await Get.find<ProfileController>().getProfile(token);
      await fetchClinicsConfig();
      initializeFields();
    });
  }

  Future<void> fetchClinicsConfig() async {
    String token = Get.find<AuthController>().token?.accessToken ?? "";
    var clinicsData = await Get.find<ProfileController>().getClinicsConfig(token);
    var profile = Get.find<ProfileController>().profile;
    currentClinicId = profile?.configId;
    setState(() {
      clinicOptions = List<Map<String, dynamic>>.from(
        clinicsData.map((clinic) => {
          'id': clinic.id ?? '',
          'name': clinic.appName ?? '',
          'address': clinic.address ?? '',
          'phone': clinic.phone ?? '',
        })
      );
      

      if (currentClinicId != null) {
        var defaultClinic = clinicOptions.firstWhere(
          (clinic) => clinic['id'].toString() == currentClinicId.toString(),
          orElse: () => clinicOptions.first,
        )['name'];
        initializeClinicDetails(defaultClinic);
      }
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
    currentClinicId = Get.find<ProfileController>().profile?.configId;
    // Get.find<ProfileController>().profile?.printDetails();
  }

  bool validatePhoneNumber(String phoneNumber) {
    // Regular expression to check if the phone number starts with 41 or 33 and is 11 digits long
    final RegExp regex = RegExp(r'^(41|33)\d{9}$');
    return regex.hasMatch(phoneNumber);
  }

  validateFields() {

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

  void initializeClinicDetails(String? selectedClinic) {
    if (selectedClinic == null) return;

    var selectedClinicData = clinicOptions.firstWhere(
      (clinic) => clinic['name'] == selectedClinic,
      orElse: () => {'name': '', 'address': '', 'phone': ''},
    );

    setState(() {
      clinicId = selectedClinicData['id'].toString();
      clinicName = selectedClinicData['name'];
      clinicAddress = selectedClinicData['address'];
      clinicPhone = selectedClinicData['phone'];
    });
  }

  void updateClinicDetails(String? selectedClinic) async {
    if (selectedClinic == null) return;

    var selectedClinicData = clinicOptions.firstWhere(
      (clinic) => clinic['name'] == selectedClinic,
      orElse: () => {'id': '', 'name': '', 'address': '', 'phone': ''},
    );

    // Convert currentClinicId to int for comparison
    int? currentClinicIdInt = int.tryParse(currentClinicId ?? '');
    
    String currentClinicName = clinicOptions.firstWhere(
      (clinic) => clinic['id'] == currentClinicIdInt,
      orElse: () => {'name': 'Unknown'},
    )['name'] as String;

    // Show confirmation dialog
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("page.confirm_clinic_change".tr),
              content: Text("page.are_you_sure".tr + " $currentClinicName " + "page.to".tr + " ${selectedClinicData['name']} ?"),
              actions: <Widget>[
                TextButton(
                  child: Text("page.no".tr),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                ElevatedButton(
                  child: isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2,
                          ),
                        )
                      : Text("page.yes".tr, style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await changeClinicHandler(selectedClinicData['id'].toString());
                            Navigator.of(context).pop(true);
                            isLoading = false;
                          } catch (error) {
                            Navigator.of(context).pop(true);
                            errorToast(error.toString());
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                ),
              ],
            );
          }
        );
      },
    );

    if (confirm == true) {
      setState(() {
        clinicId = selectedClinicData['id'].toString();
        clinicName = selectedClinicData['name'];
        clinicAddress = selectedClinicData['address'];
        clinicPhone = selectedClinicData['phone'];
      });
    } else {
      // Reset the selection to the current clinic
      setState(() {
        clinicName = currentClinicName;
      });
    }
  }

  Future<void> changeClinicHandler(String config_id) async {
    print("config_id: $config_id");
    try {
      Map<String, dynamic> data = {
        "config_id": config_id,
      };

      String token = Get.find<AuthController>().token?.accessToken ?? "";
      await Get.find<ProfileController>().changeClinic(data, token);
    } catch (error) {
      // Handle error
      print("Error changing clinic: $error");
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
                                Text("page.clinic_details".tr),
                                SizedBox(height: 20 * fem),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(20 * fem),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      select(
                                        "page.clinic_name".tr,
                                        clinicName,
                                        clinicOptions.map((clinic) => clinic['name'] as String).toList(),
                                        (String value) {
                                          updateClinicDetails(value);
                                        },
                                        required: true,
                                      ),
                                      SizedBox(height: 15 * fem),
                                      Text(
                                        "page.clinic_address".tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14 * ffem,
                                        ),
                                      ),
                                      SizedBox(height: 5 * fem),
                                      Text(
                                        clinicAddress ?? "",
                                        style: TextStyle(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w100, // Light font weight
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 15 * fem),
                                      Text(
                                        "page.clinic_phone".tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14 * ffem,
                                        ),
                                      ),
                                      SizedBox(height: 5 * fem),
                                      Text(
                                        clinicPhone ?? "",
                                        style: TextStyle(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w100, // Light font weight
                                        ),
                                      ),
                                      SizedBox(height: 20 * fem),
                                    ],
                                  ),
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
                                                      "page.FirstNameInput".tr,
                                                  required: true,
                                                  valid: fNameIsValid,
                                                  errorText:
                                                      "validation.signUp.required.FirstName"
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
                                  if (profileChanged && phoneIsValid) {
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

