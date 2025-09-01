// Widget para o seletor de intervalo de doses.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/medicine_register_viewmodel.dart';

class IntervalSelectorWidget extends StatelessWidget {
  final MedicineRegisterViewModel viewModel;

  const IntervalSelectorWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Intervalo entre as doses:'),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                final currentInterval = int.tryParse(viewModel.intervalController.text) ?? 0;
                if (currentInterval >= 1) {
                  viewModel.setIntervalHours(currentInterval - 1);
                }
              },
            ),
            SizedBox(
              width: 60,
              child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: viewModel.intervalController,
                onChanged: (value) {
                  final newInterval = int.tryParse(value);
                  if (newInterval != null) {
                    viewModel.setIntervalHours(newInterval);
                  }
                },
                validator: (value) =>
                    int.tryParse(value ?? '') == null || int.tryParse(value!)! <= 0
                        ? 'Inválido.'
                        : null,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final currentInterval = int.tryParse(viewModel.intervalController.text) ?? 0;
                viewModel.setIntervalHours(currentInterval + 1);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
