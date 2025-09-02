import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';

class EmptyMedicineListWidget extends StatelessWidget {
  const EmptyMedicineListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
              onPressed: () => Navigator.pushNamed(context, Routes.medicineRegister),
              child: const Text('Cadastrar Medicamentos'),
            ),
          ],
        ),
      ),
    );
  }
}
