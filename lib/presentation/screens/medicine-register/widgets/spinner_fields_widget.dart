import 'package:flutter/material.dart';

class SpinnerFieldsWidget extends StatelessWidget {
  final List<String> pharmaceuticalForms;
  final List<String> therapeuticCategories;
  final Function(String?) onPharmaceuticalFormSelected;
  final Function(String?) onTherapeuticCategorySelected;

  const SpinnerFieldsWidget({
    super.key,
    required this.pharmaceuticalForms,
    required this.therapeuticCategories,
    required this.onPharmaceuticalFormSelected,
    required this.onTherapeuticCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Forma farmacêutica',
            border: OutlineInputBorder(),
          ),
          items: pharmaceuticalForms
              .map((form) => DropdownMenuItem(value: form, child: Text(form)))
              .toList(),
          onChanged: onPharmaceuticalFormSelected,
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
          items: therapeuticCategories
              .map((category) => DropdownMenuItem(value: category, child: Text(category)))
              .toList(),
          onChanged: onTherapeuticCategorySelected,
          validator: (value) => value == null || value.isEmpty
              ? 'Por favor, selecione uma categoria terapêutica.'
              : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}