// Widget para exibir quando não há medicamentos cadastrados.
import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';

class EmptyMedicineWidget extends StatelessWidget {
  const EmptyMedicineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
          Text(
            Texts.noDosages,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            Texts.manageHealth,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, Routes.myMedicineList),
            icon: const Icon(Icons.add, size: 20),
            label: const Text(
              Texts.addDosage,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
