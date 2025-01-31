import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/home/controllers/home_controller.dart';
import 'package:remedio_certeiro/components/home/screens/home_screen.dart';
import 'package:remedio_certeiro/components/login/controllers/login_controller.dart';
import 'package:remedio_certeiro/components/login/screens/login_screen.dart';
import 'package:remedio_certeiro/components/medicine-register/controllers/medicine_register_controller.dart';
import 'package:remedio_certeiro/components/medicine-register/screens/medicine_register_screen.dart';
import 'package:remedio_certeiro/components/my-medicine-list/controllers/my_medicine_list_controller.dart';
import 'package:remedio_certeiro/components/my-medicine-list/screens/my_medicine_list_screen.dart';
import 'package:remedio_certeiro/components/profile/controllers/profile_controller.dart';
import 'package:remedio_certeiro/components/profile/screens/profile_screen.dart';
import 'package:remedio_certeiro/components/user-register/controllers/user_register_controller.dart';
import 'package:remedio_certeiro/components/user-register/screens/user_register_screen.dart';

class ScreensRoutes {
  static const String profile = "/profile";
  static const String login = "/login";
  static const String userRegister = "/user-register";
  static const String home = "/home";
  static const String myMedicineList = "/my-medicine-list";
  static const String medicineRegister = "/medicine-register";
  static const String medicineList = "/medicine-list";
}

Map<String, WidgetBuilder> getRoutes() {
  return {
    ScreensRoutes.login: (context) => LoginScreen(
          controller: Provider.of<LoginController>(context, listen: false),
        ),
    ScreensRoutes.userRegister: (context) => UserRegisterScreen(
          controller: Provider.of<UserRegisterController>(context, listen: false),
        ),
    ScreensRoutes.home: (context) =>
        HomeScreen(controller: Provider.of<HomeController>(context, listen: false)),
    ScreensRoutes.myMedicineList: (context) => MyMedicineListScreen(
        controller: Provider.of<MyMedicineListController>(context, listen: false)),
    ScreensRoutes.profile: (context) => ProfileScreen(
          controller: Provider.of<ProfileController>(context, listen: false),
        ),
    ScreensRoutes.medicineRegister: (context) => MedicineRegisterScreen(
        controller: Provider.of<MedicineRegisterController>(context, listen: false)),
  };
}
