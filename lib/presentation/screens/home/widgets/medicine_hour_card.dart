import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';
import 'package:remedio_certeiro/core/utils/date_formats.dart';
import 'package:remedio_certeiro/presentation/screens/home/home_viewmodel.dart';

class MedicineHourCard extends StatelessWidget {
  final Map<String, dynamic> medicine;

  const MedicineHourCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final int medicineId = medicine['id'];
    final String medicineName = medicine['name'];
    final bool isLoading = viewModel.loadingStates[medicineId] ?? false;
    final bool isRenewing = viewModel.renewingStates[medicineId] ?? false;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(medicineName),
            if (DateTime.parse(medicine['nextDoseTime']).minute == DateTime.now().minute)
              isRenewing
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    )
                  : TextButton(
                      onPressed: () => viewModel.renewDosage(medicineId, medicineName),
                      child: const Text('Renovar Dosagem', style: TextStyle(fontSize: 12)),
                    ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Próxima dose em: ${formatDosageInterval(medicine['nextDoseTime'])}'),
            isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  )
                : IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.error),
                    onPressed: () => viewModel.deleteMedicine(medicineId),
                  ),
          ],
        ),
      ),
    );
  }
}
