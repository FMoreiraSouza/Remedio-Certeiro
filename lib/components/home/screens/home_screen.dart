import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/home/controllers/home_controller.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/date_utils.dart';
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
        child: Column(
          children: [
            TextButton(
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
            Consumer<HomeController>(
              builder: (context, controller, child) {
                // Chama a função de buscar os remédios ao carregar a tela
                controller.fetchMedicineHours();

                // Caso os dados ainda não tenham sido carregados
                // if (controller.medicineHours.isEmpty) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                // Exibe os remédios em cards
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.medicineHours.length,
                    itemBuilder: (context, index) {
                      final medicine = controller.medicineHours[index];

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(medicine['name']),
                          subtitle: Text(
                              'Próxima dose em: ${formatDosageInterval(medicine['nextDoseTime'])}'),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
