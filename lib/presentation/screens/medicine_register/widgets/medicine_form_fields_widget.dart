// Widget para os campos de texto do formulário de cadastro de medicamentos.
import 'package:flutter/material.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/medicine_register_viewmodel.dart';

class MedicineFormFieldsWidget extends StatelessWidget {
  final MedicineRegisterViewModel viewModel;

  const MedicineFormFieldsWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: viewModel.nameController,
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
          controller: viewModel.dosageController,
          decoration: const InputDecoration(
            labelText: 'Dosagem (mg, ml)',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: viewModel.purposeController,
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
          controller: viewModel.useModeController,
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
