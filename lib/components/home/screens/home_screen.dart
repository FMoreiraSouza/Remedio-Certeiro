import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/home/controllers/home_controller.dart';
import 'package:remedio_certeiro/main.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/alarm_service.dart';
import 'package:remedio_certeiro/utils/date_formats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});

  final HomeController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _fetchTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.firstFecthMedicineHours();
    });
    _startFetchTimer();
  }

  @override
  void dispose() {
    _fetchTimer?.cancel();
    super.dispose();
  }

  void _startFetchTimer() {
    _fetchTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      widget.controller.fetchMedicineHours();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Remédio Certeiro"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.pushNamed(context, ScreensRoutes.profile);
                },
              ),
            ],
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: Consumer<HomeController>(
              builder: (context, controller, child) {
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
                                int medicineId = medicine['id'];
                                String medicineName = medicine['name'];
                                DateTime nextDoseTime = DateTime.parse(medicine['nextDoseTime']);
                                Duration difference = nextDoseTime.difference(DateTime.now());
                                if (difference.inMinutes == 5) {
                                  _showNotification(medicine['name']);
                                }
                                if (nextDoseTime.minute == DateTime.now().minute) {
                                  AlarmService.playAlarm();
                                }
                                return Consumer<HomeController>(
                                    builder: (context, controller, child) {
                                  bool isLoading = controller.loadingStates[medicineId] ?? false;
                                  bool isRenewing = controller.renewingStates[medicineId] ?? false;

                                  return Card(
                                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(medicine['name']),
                                          if (nextDoseTime.minute == DateTime.now().minute)
                                            Consumer<HomeController>(
                                              builder: (context, controller, child) {
                                                return isRenewing
                                                    ? const SizedBox(
                                                        height: 24,
                                                        width: 24,
                                                        child: CircularProgressIndicator(),
                                                      )
                                                    : TextButton(
                                                        style: TextButton.styleFrom(
                                                          side: const BorderSide(
                                                              color: Colors.yellow, width: 2),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(50),
                                                          ),
                                                          backgroundColor: Colors.transparent,
                                                        ),
                                                        onPressed: () {
                                                          _renewDosage(medicineId, medicineName);
                                                          AlarmService.stopAlarm();
                                                        },
                                                        child: const Text(
                                                          'Renovar Dosagem',
                                                          style: TextStyle(
                                                              color: Colors.black, fontSize: 12),
                                                        ),
                                                      );
                                              },
                                            ),
                                        ],
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Próxima dose em: ${formatDosageInterval(medicine['nextDoseTime'])}',
                                          ),
                                          isLoading
                                              ? const SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child: CircularProgressIndicator(),
                                                )
                                              : IconButton(
                                                  icon: const Icon(Icons.delete, color: Colors.red),
                                                  onPressed: () {
                                                    _deleteMedicine(medicineId);
                                                    AlarmService.stopAlarm();
                                                  },
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
        Consumer<HomeController>(
          builder: (context, value, child) {
            return Visibility(
              visible: value.isFirstLoading,
              child: Container(
                color: const Color(0xFFF5F5DC),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Future<void> _showNotification(String medicineName) async {
    AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
      'remedy_channel',
      'Remédios',
      channelDescription: 'Notificações para os medicamentos',
      importance: Importance.max,
      priority: Priority.max,
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
      payload: ScreensRoutes.home,
    );
  }

  void _renewDosage(int medicineId, String medicineName) {
    Provider.of<HomeController>(context, listen: false).renewDosage(medicineId, medicineName);
  }

  void _deleteMedicine(int medicineId) async {
    await Provider.of<HomeController>(context, listen: false).deleteMedicine(medicineId);
  }
}
