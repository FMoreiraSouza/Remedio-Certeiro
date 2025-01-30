import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/home/screens/widgets/medical_list_info.dart';
import 'package:remedio_certeiro/components/my-medicine-list/controllers/my_medicine_list_controller.dart';

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
    return ChangeNotifierProvider.value(
      value: widget.controller,
      child: Consumer<MyMedicineListController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Meus Remédios"),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          if (controller.errorMessage != null) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Meus Remédios"),
              ),
              body: Center(child: Text(controller.errorMessage!)),
            );
          }
          final remedios = controller.medicines;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Meus Remédios"),
            ),
            body: remedios.isEmpty
                ? const Center(child: Text('Nenhum remédio encontrado.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: remedios.length,
                    itemBuilder: (context, index) {
                      final remedio = remedios[index];
                      return MedicalListInfo(
                        medicine: remedio,
                        deleteMedicine: widget.controller.deleteMedicine,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
