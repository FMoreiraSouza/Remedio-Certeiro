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
    final nextDoseTime = DateTime.parse(medicine['nextDoseTime']);
    final now = DateTime.now();
    final difference = nextDoseTime.difference(now);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(medicineName),
            // Mostrar botão de renovar quando estiver no momento do alarme (com tolerância)
            if (difference.inSeconds <= 30 && difference.inSeconds >= 0)
              isRenewing
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    )
                  : IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.blue),
                      onPressed: onRenew,
                      tooltip: 'Renovar Dosagem',
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
