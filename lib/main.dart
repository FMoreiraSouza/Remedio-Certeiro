import 'package:flutter/material.dart';
import 'package:remedio_certeiro/components/health_app_bar.dart';
import 'package:remedio_certeiro/components/health_drawer_body.dart';
import 'package:remedio_certeiro/components/medical_list_info.dart';
import 'package:remedio_certeiro/components/medical_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow)),
      home: Scaffold(
        appBar: const HealthAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Flexible(
                child: MedicalListInfo(
                  name: 'Nome',
                  description: 'Descrição',
                  useMode: 'Modo de uso',
                ),
              ),
              MedicalButton(
                  function: (context) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Medicamento aplicado!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icons.medical_information,
                  text: 'Aplicar medicamento'),
            ],
          ),
        ),
        endDrawer: const HealthDrawerBody(),
      ),
    );
  }
}
