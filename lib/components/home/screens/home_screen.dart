import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/home/controllers/home_controller.dart';
import 'package:remedio_certeiro/main.dart'; // Importando o scaffoldMessengerKey
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/date_utils.dart';
import 'package:remedio_certeiro/utils/health_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<int> _notifiedMedicines = {}; // Armazena os IDs já notificados

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
                controller.fetchMedicineHours();

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.medicineHours.length,
                    itemBuilder: (context, index) {
                      final medicine = controller.medicineHours[index];
                      int medicineId = medicine['id']; // ID do remédio
                      DateTime nextDoseTime = DateTime.parse(medicine['nextDoseTime']);
                      Duration difference = nextDoseTime.difference(DateTime.now());

                      // Verifica se faltam exatamente 5 minutos e se já não notificou esse remédio antes
                      if (difference.inMinutes == 5 && !_notifiedMedicines.contains(medicineId)) {
                        _showNotification(medicine['name']);
                        _notifiedMedicines.add(medicineId); // Marca como notificado
                      }

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(medicine['name']),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteMedicine(medicineId),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Próxima dose em: ${formatDosageInterval(medicine['nextDoseTime'])}',
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                                onPressed: () => _renewDosage(medicineId),
                                child: const Text(
                                  'Renovar Dosagem',
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
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

  Future<void> _showNotification(String medicineName) async {
    AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
      'remedy_channel',
      'Remédios',
      channelDescription: 'Notificações para os medicamentos',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Alerta de Dose',
      'Em 5 minutos tome seu $medicineName',
      platformDetails,
    );
  }

  void _renewDosage(int medicineId) {
    // Adicione aqui a lógica para renovar a dosagem (exemplo: atualizar o horário da próxima dose no banco de dados)
    print("Renovando dosagem para o medicamento ID: $medicineId");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Dosagem renovada com sucesso!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _deleteMedicine(int medicineId) async {
    await Provider.of<HomeController>(context, listen: false).deleteMedicine(medicineId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Medicamento removido com sucesso!"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
