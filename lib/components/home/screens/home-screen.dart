import 'package:flutter/material.dart';
import 'package:remedio_certeiro/components/home/screens/widgets/medical-list-info.dart';
import 'package:remedio_certeiro/utils/health-app-bar.dart';
import 'package:remedio_certeiro/utils/medicine-list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HealthAppBar(
        title: "Meus Remédios",
      ),
      // drawer: const HealthDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: remedios.length,
        itemBuilder: (context, index) {
          final remedio = remedios[index];
          return MedicalListInfo(
            name: remedio["name"] ?? "",
            description: remedio["description"] ?? "",
            useMode: remedio["useMode"] ?? "",
          );
        },
      ),
    );
  }
}
