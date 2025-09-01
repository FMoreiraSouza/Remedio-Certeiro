import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';
import 'package:remedio_certeiro/core/utils/date_formats.dart';

class MedicineHourCard extends StatelessWidget {
  final Map<String, dynamic> medicine;
  final bool isLoading;
  final bool isRenewing;
  final VoidCallback onDelete;
  final VoidCallback onRenew;

  const MedicineHourCard({
    super.key, 
    required this.medicine,
    required this.isLoading,
    required this.isRenewing,
    required this.onDelete,
    required this.onRenew,
  });

  @override
  Widget build(BuildContext context) {
    final String medicineName = medicine['name'];

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
                      onPressed: onRenew,
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
                    onPressed: onDelete,
                  ),
          ],
        ),
      ),
    );
  }
}