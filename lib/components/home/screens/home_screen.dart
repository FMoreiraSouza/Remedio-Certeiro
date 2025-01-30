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
  final List<DateTime> _nextDoseTimes = []; // Armazena os valores de nextDoseTime

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HealthAppBar(
        title: "Meus Remédios",
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Consumer<HomeController>(
          builder: (context, controller, child) {
            controller.fetchMedicineHours();
            return controller.medicineHours.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_services_outlined,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Sem dosagens definidas",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Gerencie sua saúde agora!",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, ScreensRoutes.myMedicineList);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 3,
                          ),
                          icon: const Icon(Icons.add, size: 20),
                          label: const Text(
                            "Adicionar dosagem",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.medicineHours.length,
                          itemBuilder: (context, index) {
                            final medicine = controller.medicineHours[index];
                            int medicineId = medicine['id']; // ID do remédio
                            String medicineName = medicine['name']; // Nome do remédio
                            DateTime nextDoseTime = DateTime.parse(medicine['nextDoseTime']);
                            Duration difference = nextDoseTime.difference(DateTime.now());

                            // Verifica se faltam exatamente 5 minutos e se já não notificou esse remédio antes
                            if (difference.inMinutes == 5 &&
                                !_notifiedMedicines.contains(medicineId)) {
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
                                    // Verifica se a próxima dose é no momento exato
                                    if (nextDoseTime.minute == DateTime.now().minute)
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          side: const BorderSide(color: Colors.blue, width: 2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        onPressed: () => _renewDosage(medicineId, medicineName),
                                        child: const Text(
                                          'Renovar Dosagem',
                                          style: TextStyle(color: Colors.black, fontSize: 12),
                                        ),
                                      )
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Próxima dose em: ${formatDosageInterval(medicine['nextDoseTime'])}',
                                    ),
                                    Consumer<HomeController>(
                                      builder: (context, controller, child) {
                                        bool isLoading =
                                            controller.loadingStates[medicineId] ?? false;
                                        return isLoading
                                            ? const SizedBox(
                                                height: 24, // Tamanho desejado
                                                width: 24, // Tamanho desejado
                                                child: CircularProgressIndicator(),
                                              )
                                            : IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () => _deleteMedicine(medicineId),
                                              );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
          },
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

  void _renewDosage(int medicineId, String medicineName) {
    // Chama a renovação de dosagem
    Provider.of<HomeController>(context, listen: false).renewDosage(medicineId, medicineName);
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
