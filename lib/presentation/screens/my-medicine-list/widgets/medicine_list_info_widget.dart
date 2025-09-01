import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';
import 'package:remedio_certeiro/core/utils/date_formats.dart';
import 'package:remedio_certeiro/data/models/medicine_model.dart';

class MedicineListInfoWidget extends StatelessWidget {
  const MedicineListInfoWidget({
    super.key,
    required this.medicine,
    required this.saveMedicine,
    required this.deleteMedicine,
  });

  final MedicineModel medicine;
  final Future<void> Function(String) deleteMedicine;
  final Future<void> Function(String, DateTime) saveMedicine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(color: AppColors.primary),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: AppColors.error),
                      onPressed: () async {
                        await deleteMedicine(medicine.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Medicamento removido com sucesso!")),
                          );
                        }
                      },
                    ),
                    Expanded(child: Text(medicine.name ?? '', textAlign: TextAlign.center)),
                    Text(medicine.dosage ?? '', style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.medication),
                      title: Text(medicine.therapeuticCategory ?? '',
                          style: const TextStyle(fontSize: 14)),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.local_pharmacy),
                      title: Text(medicine.pharmaceuticalForm ?? '',
                          style: const TextStyle(fontSize: 14)),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: Text(medicine.purpose ?? '', style: const TextStyle(fontSize: 14)),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text(medicine.useMode ?? '', style: const TextStyle(fontSize: 14)),
              ),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(
                  formatExpirationDate(medicine.expirationDate?.toIso8601String() ?? ''),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final nextDoseTime =
                          DateTime.now().add(Duration(minutes: medicine.interval ?? 0));
                      await saveMedicine(medicine.name ?? "Nome Indefinido", nextDoseTime);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Dose aplicada para ${medicine.name}")),
                        );
                      }
                    },
                    child: const Text("Aplicar Dose"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
