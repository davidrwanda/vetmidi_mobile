// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';

import '../../core/utils/app_constants.dart';
import '../../models/clinic.dart';

class SelectClinics extends StatefulWidget {
  SelectClinics({super.key, required this.setClinic});
  Function setClinic;

  @override
  State<SelectClinics> createState() => _SelectClinicsState();
}

class _SelectClinicsState extends State<SelectClinics> {
  TextEditingController _searchText = TextEditingController();
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 500), () async {
      await Get.find<AuthController>().getClinics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_left),
                    Text(
                      "page.back".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Divider(),
              Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: ThemeColors.primaryGrey3,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: TextField(
                        obscureText: false,
                        readOnly: false,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 15 * ffem,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15 * ffem,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            Get.find<AuthController>().searchClinic(value);
                          } else {
                            Get.find<AuthController>().resetClinics();
                          }
                        },
                        controller: _searchText,
                      )),
                    ],
                  )),
              Expanded(
                child: Obx(() {
                  return Get.find<AuthController>().loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView(
                          children: [
                            ...Get.find<AuthController>()
                                .clinics
                                .map((e) => clinicItem(e!))
                                .toList(),
                          ],
                        );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector clinicItem(Clinic clinic) {
    return GestureDetector(
      onTap: (() {
        widget.setClinic(clinic);
        Get.back();
      }),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ThemeColors.primaryGrey4,
            ),
          ),
        ),
        padding: EdgeInsets.only(bottom: 7),
        margin: EdgeInsets.only(top: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 100,
              child: clinic.logo == ""
                  ? Image.asset("assets/images/clinic_image.png")
                  : Image.network(clinic.logo),
            ),
            Text(clinic.app_name),
          ],
        ),
      ),
    );
  }
}
