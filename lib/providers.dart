import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:remedio_certeiro/components/home/controllers/home-controller.dart';
import 'package:remedio_certeiro/components/home/screens/home-screen.dart';
import 'package:remedio_certeiro/components/login/controllers/login_controller.dart';
import 'package:remedio_certeiro/components/login/screens/login-screen.dart';
import 'package:remedio_certeiro/components/user-register/controllers/user-register-controller.dart';
import 'package:remedio_certeiro/components/user-register/screens/user-register-screen.dart';
import 'package:remedio_certeiro/screens_routes.dart';

List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider(create: (_) => LoginController()),
    ChangeNotifierProvider(create: (_) => UserRegisterController()),
    ChangeNotifierProvider(create: (_) => HomeController()),
    // ChangeNotifierProvider(create: (_) => MedicineRegisterController()),
    // ChangeNotifierProvider(create: (_) => MedicineListController()),
  ];
}

Map<String, WidgetBuilder> getRoutes() {
  return {
    ScreensRoutes.login: (context) => const LoginScreen(),
    ScreensRoutes.userRegister: (context) => const UserRegisterScreen(),
    ScreensRoutes.home: (context) => const HomeScreen(),
    // ScreensRoutes.medicineRegister: (context) => const MedicineRegisterScreen(),
    // ScreensRoutes.medicineList: (context) => const MedicineListScreen(),
  };
}
