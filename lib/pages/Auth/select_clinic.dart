// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';

import '../../models/clinic.dart';

class SelectClinics extends StatefulWidget {
  SelectClinics({super.key, required this.setClinic});
  Function setClinic;

  @override
  State<SelectClinics> createState() => _SelectClinicsState();
}

class _SelectClinicsState extends State<SelectClinics> {
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
              Row(
                children: [
                  Icon(Icons.keyboard_arrow_left),
                  Text(
                    "Back",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              Text("Search"),
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
                child: Image.asset("assets/images/clinic_image.png")),
            Text(clinic.app_name),
          ],
        ),
      ),
    );
  }
}
