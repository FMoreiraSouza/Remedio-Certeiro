import 'package:flutter/material.dart';
import 'package:remedio_certeiro/components/home/screens/home-screen.dart';
import 'package:remedio_certeiro/components/login/screens/login-screen.dart';
import 'package:remedio_certeiro/components/medicine-register/screens/medicine-register-screen.dart';
import 'package:remedio_certeiro/components/profile/screens/profile-screen.dart';
import 'package:remedio_certeiro/components/user-register/screens/user-register-screen.dart';

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
    ScreensRoutes.login: (context) => const LoginScreen(),
    ScreensRoutes.userRegister: (context) => const UserRegisterScreen(),
    ScreensRoutes.home: (context) => const HomeScreen(),
    ScreensRoutes.profile: (context) => const ProfileScreen(),
    ScreensRoutes.medicineRegister: (context) => const MedicineRegisterScreen(),
    // ScreensRoutes.medicineList: (context) => const MedicineListScreen(),
  };
}
