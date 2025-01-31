import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/home/controllers/home_controller.dart';
import 'package:remedio_certeiro/components/home/screens/widgets/medicine_list_info.dart';
import 'package:remedio_certeiro/components/my-medicine-list/controllers/my_medicine_list_controller.dart';
import 'package:remedio_certeiro/screens_routes.dart';

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
        final remedios = controller.medicines;
        if (controller.isLoading) {
          return Center(
            child: Container(
              color: const Color(0xFFF5F5DC),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Meus Remédios"),
            actions: [
              IconButton(
                icon: const Icon(Icons.medical_services),
                onPressed: () {
                  Navigator.pushNamed(context, ScreensRoutes.medicineRegister);
                },
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                Provider.of<HomeController>(context, listen: false).firstFecthMedicineHours();
              },
            ),
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
                    return MedicineListInfo(
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
