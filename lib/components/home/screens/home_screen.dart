import 'package:flutter/material.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/health_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HealthAppBar(
        title: "Meus Remédios",
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: TextButton(
          style: TextButton.styleFrom(
            side: const BorderSide(color: Colors.yellow, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.transparent,
          ),
          onPressed: () {
            Navigator.pushNamed(context, ScreensRoutes.myMedicineList);
          },
          child: const Text(
            'Meus Remédios',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
