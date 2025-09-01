import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/medicine_register_viewmodel.dart';

class MedicineRegisterView extends StatefulWidget {
  const MedicineRegisterView({super.key});

  @override
  State<MedicineRegisterView> createState() => _MedicineRegisterViewState();
}

class _MedicineRegisterViewState extends State<MedicineRegisterView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<MedicineRegisterViewModel>().loadData();
  }

  @override
  void dispose() {
    context.read<MedicineRegisterViewModel>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Remédio')),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Consumer<MedicineRegisterViewModel>(
          builder: (context, viewModel, child) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: viewModel.nameController,
                    decoration: const InputDecoration(
                        labelText: 'Nome do remédio', border: OutlineInputBorder()),
                    textInputAction: TextInputAction.next,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Por favor, insira o nome do remédio.'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.dosageController,
                    decoration: const InputDecoration(
                        labelText: 'Dosagem (mg, ml)', border: OutlineInputBorder()),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.purposeController,
                    decoration:
                        const InputDecoration(labelText: 'Propósito', border: OutlineInputBorder()),
                    textInputAction: TextInputAction.next,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Por favor, insira o propósito do remédio.'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.useModeController,
                    decoration: const InputDecoration(
                        labelText: 'Modo de uso', border: OutlineInputBorder()),
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Por favor, informe o modo de uso do remédio.'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  const Text('Intervalo entre as doses:'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          final currentInterval =
                              int.tryParse(viewModel.intervalController.text) ?? 0;
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
                          final currentInterval =
                              int.tryParse(viewModel.intervalController.text) ?? 0;
                          viewModel.setIntervalHours(currentInterval + 1);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        labelText: 'Forma farmacêutica', border: OutlineInputBorder()),
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
                        labelText: 'Classe terapêutica', border: OutlineInputBorder()),
                    items: viewModel.therapeuticCategories
                        .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                        .toList(),
                    onChanged: (value) => viewModel.selectedTherapeuticCategory = value,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Por favor, selecione uma categoria terapêutica.'
                        : null,
                  ),
                  const SizedBox(height: 16),
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
                          child:
                              SizedBox(width: 25, height: 25, child: CircularProgressIndicator()),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  viewModel.expirationDate != null) {
                                viewModel.saveMedicine(context);
                              } else if (viewModel.expirationDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Por favor, selecione a data de validade.')),
                                );
                              }
                            },
                            child: const Text('Salvar medicamento'),
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
