import 'package:flutter/material.dart';

class DateSaveWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final DateTime? expirationDate;
  final bool isLoading;
  final Function(DateTime) onDateSelected;
  final VoidCallback onSave;

  const DateSaveWidget({
    super.key,
    required this.formKey,
    required this.expirationDate,
    required this.isLoading,
    required this.onDateSelected,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            expirationDate == null
                ? 'Selecione a data de validade'
                : 'Validade: ${expirationDate?.day}/${expirationDate?.month}/${expirationDate?.year}',
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
              onDateSelected(pickedDate);
            }
          },
        ),
        const SizedBox(height: 16),
        isLoading
            ? const Align(
                alignment: Alignment.center,
                child: SizedBox(width: 25, height: 25, child: CircularProgressIndicator()),
              )
            : Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: onSave,
                  child: const Text('Salvar medicamento'),
                ),
              ),
      ],
    );
  }
}