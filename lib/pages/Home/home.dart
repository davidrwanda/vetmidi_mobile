import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/pages/Home/appointments_card.dart';
import 'package:vetmidi/pages/Home/home_pet_avatar.dart';
import 'package:vetmidi/pages/Home/treatments_list.dart';
import 'package:vetmidi/pages/Notifications/notifications.dart';
import 'package:vetmidi/routes/index.dart';

import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';
import 'appointments_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: ThemeColors.primaryBackground,
      padding: EdgeInsets.all(20 * fem),
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hello, Sam!",
                style: TextStyle(
                  fontSize: 33 * ffem,
                  fontWeight: FontWeight.w800,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.notifications),
                child: Container(
                  padding: EdgeInsets.all(8 * fem),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10 * fem),
                      color: Colors.white),
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 29,
                    color: ThemeColors.secondaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10 * fem),
          Text("Your Pets"),
          SizedBox(height: 10 * fem),
          Container(
            height: 120 * fem,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                homePetAvatar("assets/images/dog.png", "Luna"),
                homePetAvatar("assets/images/dog.png", "Bella"),
                Container(
                  height: 95 * fem,
                  width: 75 * fem,
                  margin: EdgeInsets.only(top: 7 * fem),
                  decoration: BoxDecoration(
                    color: ThemeColors.secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20 * fem),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: ThemeColors.secondaryColor,
                        size: 30 * ffem,
                      ),
                      SizedBox(height: 5 * fem),
                      Text(
                        "Add Pet",
                        style: TextStyle(
                          fontSize: 13 * ffem,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20 * fem),
          appointmentList(),
          treatmentList(),
        ],
      ),
    ));
  }
}
