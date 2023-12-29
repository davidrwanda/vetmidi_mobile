import 'package:get/get.dart';
import 'package:vetmidi/core/bindings/home_bindings.dart';
import 'package:vetmidi/pages/Home/appointment_details.dart';
import 'package:vetmidi/pages/Notifications/notifications.dart';
import 'package:vetmidi/pages/Pets/new_pet.dart';
import 'package:vetmidi/pages/Pets/pet_details.dart';
import 'package:vetmidi/pages/Pets/pet_profile.dart';
import 'package:vetmidi/pages/Pets/pets.dart';
import 'package:vetmidi/pages/Profile/profile.dart';
import 'package:vetmidi/pages/home.dart';

import '../pages/Auth/change_password.dart';
import '../pages/Auth/login.dart';
import '../pages/Home/appointments.dart';
import '../pages/Home/treatment_details.dart';
import '../pages/Pets/edit_pet_details.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String profile = "/profile";
  static const String mypets = "/mypets";
  static const String newpet = "/newpet";
  static const String petdetails = "/petdetails";
  static const String addpet = "/addpet";
  static const String editpetdetails = "/editpetdetails";
  static const String notifications = "/notifications";
  static const String appointmentdetails = "/appointmentdetails";
  static const String treatmentdetails = "/treatmentdetails";
  static const String petprofile = "/petprofile";
  static const String appointments = "/appointments";
  static const String changePassword = "/changepassword";

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
    GetPage(name: notifications, page: () => const NotificationsScreen()),
    GetPage(name: appointmentdetails, page: () => const AppointmentDetails()),
    GetPage(name: treatmentdetails, page: () => const TreatmentDetails()),
    GetPage(name: petprofile, page: () => const PetProfile()),
    GetPage(name: appointments, page: () => AppointmentsScreen()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: addpet, page: () => NewPet()),
  ];
}
