import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/core/utils/date_formats.dart';
import 'package:remedio_certeiro/presentation/screens/home/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchMedicineHours(isFirstFetch: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(Texts.appName),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => Navigator.pushNamed(context, Routes.profile),
              ),
            ],
          ),
          body: Consumer<HomeViewModel>(
            builder: (context, viewModel, child) {
              return viewModel.medicineHours.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.medical_services_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(Texts.noDosages,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              )),
                          const SizedBox(height: 4),
                          Text(Texts.manageHealth,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              )),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pushNamed(context, Routes.myMedicineList),
                            icon: const Icon(Icons.add, size: 20),
                            label: const Text(Texts.addDosage,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, Routes.myMedicineList),
                          child: const Text(Texts.myMedicines),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.medicineHours.length,
                            itemBuilder: (context, index) {
                              final medicine = viewModel.medicineHours[index];
                              final int medicineId = medicine['id'];
                              final String medicineName = medicine['name'];
                              return Consumer<HomeViewModel>(
                                builder: (context, viewModel, child) {
                                  final bool isLoading =
                                      viewModel.loadingStates[medicineId] ?? false;
                                  final bool isRenewing =
                                      viewModel.renewingStates[medicineId] ?? false;
                                  return Card(
                                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(medicineName),
                                          if (DateTime.parse(medicine['nextDoseTime']).minute ==
                                              DateTime.now().minute)
                                            isRenewing
                                                ? const SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child: CircularProgressIndicator())
                                                : TextButton(
                                                    onPressed: () => viewModel.renewDosage(
                                                        medicineId, medicineName),
                                                    child: const Text('Renovar Dosagem',
                                                        style: TextStyle(fontSize: 12)),
                                                  ),
                                        ],
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Próxima dose em: ${formatDosageInterval(medicine['nextDoseTime'])}'),
                                          isLoading
                                              ? const SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child: CircularProgressIndicator())
                                              : IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: AppColors.error),
                                                  onPressed: () =>
                                                      viewModel.deleteMedicine(medicineId),
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Visibility(
              visible: viewModel.isFirstLoading,
              child: Container(
                  color: AppColors.background,
                  child: const Center(child: CircularProgressIndicator())),
            );
          },
        ),
      ],
    );
  }
}
