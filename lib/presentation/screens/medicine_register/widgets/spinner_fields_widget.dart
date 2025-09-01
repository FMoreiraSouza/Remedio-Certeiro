import 'package:flutter/material.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/medicine_register_viewmodel.dart';

class SpinnerFieldsWidget extends StatelessWidget {
  final MedicineRegisterViewModel viewModel;

  const SpinnerFieldsWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Forma farmacêutica',
            border: OutlineInputBorder(),
          ),
          items: viewModel.pharmaceuticalForms
              .map((form) => DropdownMenuItem(value: form, child: Text(form)))
              .toList(),
          onChanged: (value) => viewModel.selectedPharmaceuticalForm = value,
          validator: (value) => value == null || value.isEmpty
              ? 'Por favor, selecione uma forma farmacêutica.'
              : null,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Classe terapêutica',
            border: OutlineInputBorder(),
          ),
          items: viewModel.therapeuticCategories
              .map((category) => DropdownMenuItem(value: category, child: Text(category)))
              .toList(),
          onChanged: (value) => viewModel.selectedTherapeuticCategory = value,
          validator: (value) => value == null || value.isEmpty
              ? 'Por favor, selecione uma categoria terapêutica.'
              : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
