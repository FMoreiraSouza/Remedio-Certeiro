import 'package:flutter/material.dart';
import 'package:remedio_certeiro/components/medicine-register/controllers/medicine_register_controller.dart';

class MedicineRegisterScreen extends StatelessWidget {
  const MedicineRegisterScreen({super.key, required this.controller});

  final MedicineRegisterController controller;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController dosageController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController reminderController = TextEditingController();
    DateTime? expirationDate;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Remédio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              // Nome do remédio
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do remédio',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do remédio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Dosagem
              TextFormField(
                controller: dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosagem (Ex.: 500mg, 10ml)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Forma farmacêutica (menu suspenso)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Forma farmacêutica',
                  border: OutlineInputBorder(),
                ),
                items: controller.pharmaceuticalForms
                    .map((form) => DropdownMenuItem(
                          value: form,
                          child: Text(form),
                        ))
                    .toList(),
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione uma forma farmacêutica.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Categoria ou classe terapêutica (menu suspenso)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Classe terapêutica',
                  border: OutlineInputBorder(),
                ),
                items: controller.therapeuticCategories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione uma categoria terapêutica.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Quantidade disponível
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantidade disponível',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade disponível.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Insira um número válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Data de validade
              ListTile(
                title: Text(
                  expirationDate == null
                      ? 'Selecione a data de validade'
                      : 'Validade: ${expirationDate.day}/${expirationDate.month}/${expirationDate.year}',
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
                    expirationDate = pickedDate;
                  }
                },
              ),
              const SizedBox(height: 16),

              // Lembrete de reposição
              TextFormField(
                controller: reminderController,
                decoration: const InputDecoration(
                  labelText: 'Lembrete de reposição (opcional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),

              // Botão de cadastro
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cadastro realizado com sucesso!')),
                    );
                  }
                },
                child: const Text('Salvar medicamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
