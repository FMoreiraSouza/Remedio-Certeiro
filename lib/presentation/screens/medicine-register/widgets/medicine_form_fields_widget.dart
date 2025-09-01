import 'package:flutter/material.dart';

class MedicineFormFieldsWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController dosageController;
  final TextEditingController purposeController;
  final TextEditingController useModeController;

  const MedicineFormFieldsWidget({
    super.key,
    required this.nameController,
    required this.dosageController,
    required this.purposeController,
    required this.useModeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Nome do remédio',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          validator: (value) =>
              value == null || value.isEmpty ? 'Por favor, insira o nome do remédio.' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: dosageController,
          decoration: const InputDecoration(
            labelText: 'Dosagem (mg, ml)',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: purposeController,
          decoration: const InputDecoration(
            labelText: 'Propósito',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          validator: (value) =>
              value == null || value.isEmpty ? 'Por favor, insira o propósito do remédio.' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: useModeController,
          decoration: const InputDecoration(
            labelText: 'Modo de uso',
            border: OutlineInputBorder(),
          ),
          maxLines: null,
          textInputAction: TextInputAction.done,
          validator: (value) => value == null || value.isEmpty
              ? 'Por favor, informe o modo de uso do remédio.'
              : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}