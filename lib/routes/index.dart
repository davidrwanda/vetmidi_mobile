import 'package:get/get.dart';
import 'package:vetmidi/core/bindings/home_bindings.dart';
import 'package:vetmidi/pages/Pets/new_pet.dart';
import 'package:vetmidi/pages/Pets/pet_details.dart';
import 'package:vetmidi/pages/Pets/pets.dart';
import 'package:vetmidi/pages/Profile/profile.dart';
import 'package:vetmidi/pages/home.dart';

import '../pages/Auth/login.dart';
import '../pages/Pets/edit_pet_details.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String profile = "/profile";
  static const String mypets = "/mypets";
  static const String newpet = "/newpet";
  static const String petdetails = "/petdetails";
  static const String editpetdetails = "/editpetdetails";

  static final routes = [
    // GetPage(name: home, page: () => const HomeScreen(), middlewares: [
    //   AuthMiddleware(),
    // ]),
    // GetPage(name: login, page: () => const Login(), binding: HomeBinding()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(
      name: login,
      page: () => const Login(),
      binding: HomeBinding(),
    ),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: mypets, page: () => const MyPetsScreen()),
    GetPage(name: newpet, page: () => const NewPet()),
    GetPage(name: petdetails, page: () => const PetDetailsScreen()),
    GetPage(name: editpetdetails, page: () => const EditPetDetailsScreen()),
  ];
}
