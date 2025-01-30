import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/home/screens/widgets/medical_list_info.dart';
import 'package:remedio_certeiro/components/my-medicine-list/controllers/my_medicine_list_controller.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/health_app_bar.dart';

class MyMedicineListScreen extends StatefulWidget {
  const MyMedicineListScreen({super.key, required this.controller});

  final MyMedicineListController controller;

  @override
  State<MyMedicineListScreen> createState() => _MyMedicineListScreenState();
}

class _MyMedicineListScreenState extends State<MyMedicineListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.fetchMedicines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyMedicineListController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Scaffold(
            appBar: HealthAppBar(
              title: "Meus Remédios",
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final remedios = controller.medicines;
        return Scaffold(
          appBar: const HealthAppBar(
            title: "Meus Remédios",
            isHomeScreen: false,
          ),
          body: remedios.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_services,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Ainda não possui medicamentos cadastrados.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Cadastre agora e comece a controlar seus medicamentos!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ScreensRoutes.medicineRegister);
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
                          child: const Text('Cadastrar Medicamentos'),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: remedios.length,
                  itemBuilder: (context, index) {
                    final remedio = remedios[index];
                    return MedicalListInfo(
                      medicine: remedio,
                      deleteMedicine: widget.controller.deleteMedicine,
                      saveMedicine: widget.controller.saveMedicine,
                    );
                  },
                ),
        );
      },
    );
  }
}
