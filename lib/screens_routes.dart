import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/home/screens/home_screen.dart';
import 'package:remedio_certeiro/components/login/controllers/login_controller.dart';
import 'package:remedio_certeiro/components/login/screens/login_screen.dart';
import 'package:remedio_certeiro/components/medicine-register/screens/medicine_register_screen.dart';
import 'package:remedio_certeiro/components/profile/screens/profile_screen.dart';
import 'package:remedio_certeiro/components/user-register/controllers/user_register_controller.dart';
import 'package:remedio_certeiro/components/user-register/screens/user_register_screen.dart';

class ScreensRoutes {
  static const String profile = "/profile";
  static const String login = "/login";
  static const String userRegister = "/user-register";
  static const String home = "/home";
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
    ScreensRoutes.home: (context) => const HomeScreen(),
    ScreensRoutes.profile: (context) => const ProfileScreen(),
    ScreensRoutes.medicineRegister: (context) => const MedicineRegisterScreen(),
    // ScreensRoutes.medicineList: (context) => const MedicineListScreen(),
  };
}
