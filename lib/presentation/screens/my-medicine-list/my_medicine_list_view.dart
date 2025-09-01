// Tela para exibir a lista de medicamentos cadastrados.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/presentation/screens/home/home_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/my-medicine-list/my_medicine_list_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/my-medicine-list/widgets/empty_medicine_list_widget.dart';
import 'package:remedio_certeiro/presentation/screens/my-medicine-list/widgets/medicine_list_info_widget.dart';

class MyMedicineListView extends StatefulWidget {
  const MyMedicineListView({super.key});

  @override
  State<MyMedicineListView> createState() => _MyMedicineListViewState();
}

class _MyMedicineListViewState extends State<MyMedicineListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyMedicineListViewModel>().fetchMedicines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyMedicineListViewModel>(
      builder: (context, viewModel, child) {
        final medicines = viewModel.medicines;
        if (viewModel.isLoading) {
          return Center(
            child: Container(
              color: AppColors.background,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text(Texts.myMedicines),
            actions: [
              IconButton(
                icon: const Icon(Icons.medical_services),
                onPressed: () => Navigator.pushNamed(context, Routes.medicineRegister),
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                context.read<HomeViewModel>().fetchMedicineHours(isFirstFetch: true);
              },
            ),
          ),
          body: medicines.isEmpty
              ? const EmptyMedicineListWidget()
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = medicines[index];
                    return MedicineListInfoWidget(
                      medicine: medicine,
                      deleteMedicine: viewModel.deleteMedicine,
                      saveMedicine: viewModel.saveMedicineHour,
                    );
                  },
                ),
        );
      },
    );
  }
}
