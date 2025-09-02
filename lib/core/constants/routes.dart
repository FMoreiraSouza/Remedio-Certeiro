import 'package:flutter/material.dart';
import 'package:remedio_certeiro/presentation/screens/home/home_view.dart';
import 'package:remedio_certeiro/presentation/screens/login/login_view.dart';
import 'package:remedio_certeiro/presentation/screens/medicine-register/medicine_register_view.dart';
import 'package:remedio_certeiro/presentation/screens/my-medicine-list/my_medicine_list_view.dart';
import 'package:remedio_certeiro/presentation/screens/profile/profile_view.dart';
import 'package:remedio_certeiro/presentation/screens/user-register/user_register_view.dart';

class Routes {
  static const String login = "/login";
  static const String userRegister = "/user-register";
  static const String home = "/home";
  static const String profile = "/profile";
  static const String myMedicineList = "/my-medicine-list";
  static const String medicineRegister = "/medicine-register";

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.login: (context) => const LoginView(),
      Routes.userRegister: (context) => const UserRegisterView(),
      Routes.home: (context) => const HomeView(),
      Routes.profile: (context) => const ProfileView(),
      Routes.myMedicineList: (context) => const MyMedicineListView(),
      Routes.medicineRegister: (context) => const MedicineRegisterView(),
    };
  }
}
