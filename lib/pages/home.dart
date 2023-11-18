import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/pages/Pets/new_pet.dart';
import 'package:vetmidi/pages/Pets/pets.dart';
import 'package:vetmidi/pages/Profile/profile.dart';
import 'package:vetmidi/pages/Records/medical_records.dart';

import '../core/theme/colors_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var bottomNavigationBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: "Profile",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.pets),
      label: "Pets",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: "Add",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long),
      label: "Records",
    ),
  ];

  final List<Widget> _pages = [
    const ProfileScreen(),
    const MyPetsScreen(),
    const NewPet(),
    const MedicalRecords(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          body: _pages[Get.find<AuthController>().selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: bottomNavigationBarItems,
            currentIndex: Get.find<AuthController>().selectedTab,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 16,
            unselectedFontSize: 16,
            onTap: (index) {
              Get.find<AuthController>().selectedTab = index;
              // setState(() {
              //   _currentIndex = index;
              // });
            },
            selectedItemColor: ThemeColors.secondaryColor,
            unselectedItemColor: ThemeColors.textColor,
            backgroundColor: ThemeColors.primaryGrey3,
          ),
        );
      }),
    );
  }
}
