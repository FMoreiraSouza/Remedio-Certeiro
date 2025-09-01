import 'package:flutter/material.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/medicine_register_viewmodel.dart';

class DateSaveWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final MedicineRegisterViewModel viewModel;

  const DateSaveWidget({super.key, required this.formKey, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            viewModel.expirationDate == null
                ? 'Selecione a data de validade'
                : 'Validade: ${viewModel.expirationDate?.day}/${viewModel.expirationDate?.month}/${viewModel.expirationDate?.year}',
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              viewModel.setExpirationDate(pickedDate);
            }
          },
        ),
        const SizedBox(height: 16),
        viewModel.isLoading
            ? const Align(
                alignment: Alignment.center,
                child: SizedBox(width: 25, height: 25, child: CircularProgressIndicator()),
              )
            : Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() && viewModel.expirationDate != null) {
                      viewModel.saveMedicine(context);
                    } else if (viewModel.expirationDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Por favor, selecione a data de validade.')),
                      );
                    }
                  },
                  child: const Text('Salvar medicamento'),
                ),
              ),
      ],
    );
  }
}
