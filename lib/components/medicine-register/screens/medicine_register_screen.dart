import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/medicine-register/controllers/medicine_register_controller.dart';
import 'package:flutter/services.dart';

class MedicineRegisterScreen extends StatefulWidget {
  const MedicineRegisterScreen({super.key, required this.controller});

  final MedicineRegisterController controller;

  @override
  State<MedicineRegisterScreen> createState() => _MedicineRegisterScreenState();
}

class _MedicineRegisterScreenState extends State<MedicineRegisterScreen> {
  @override
  void initState() {
    super.initState();
    // Definir o valor inicial do intervalo como 0
    widget.controller.intervalController.text = '0';
    widget.controller.loadData();
  }

  @override
  void dispose() {
    // Limpar os dados ao sair da tela
    widget.controller.clearData();
    widget.controller.clearExpirationDate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Remédio'),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: widget.controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do remédio',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do remédio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: widget.controller.dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosagem (mg, ml)',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: widget.controller.purposeController,
                decoration: const InputDecoration(
                  labelText: 'Propósito',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o propósito do remédio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: widget.controller.useModeController,
                decoration: const InputDecoration(
                  labelText: 'Modo de uso',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o modo de uso do remédio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Label e Intervalo com botões de incrementar e decrementar
              const Text(
                'Intervalo entre as doses:',
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      final currentText = widget.controller.intervalController.text;
                      if (currentText.isNotEmpty) {
                        final currentInterval = int.tryParse(currentText);
                        if (currentInterval != null && currentInterval >= 1) {
                          final newInterval = currentInterval - 1;
                          widget.controller.intervalController.text = newInterval.toString();
                          widget.controller.setIntervalHours(newInterval);
                        }
                      }
                    },
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: widget.controller.intervalController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          final newInterval = int.tryParse(value);
                          if (newInterval != null) {
                            widget.controller.setIntervalHours(newInterval);
                          }
                        }
                      },
                      validator: (value) {
                        final intValue = int.tryParse(value ?? '');
                        if (intValue == null || intValue <= 0) {
                          return 'Inválido.';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      final currentText = widget.controller.intervalController.text;
                      if (currentText.isNotEmpty) {
                        final currentInterval = int.tryParse(currentText);
                        if (currentInterval != null) {
                          final newInterval = currentInterval + 1;
                          widget.controller.intervalController.text = newInterval.toString();
                          widget.controller.setIntervalHours(newInterval);
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Consumer<MedicineRegisterController>(builder: (context, controller, child) {
                return Column(
                  children: [
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
                      onChanged: (value) {
                        controller.selectedPharmaceuticalForm = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione uma forma farmacêutica.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                      onChanged: (value) {
                        controller.selectedTherapeuticCategory = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione uma categoria terapêutica.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: Text(
                        widget.controller.expirationDate == null
                            ? 'Selecione a data de validade'
                            : 'Validade: ${widget.controller.expirationDate?.day}/${widget.controller.expirationDate?.month}/${widget.controller.expirationDate?.year}',
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
                          widget.controller.setExpirationDate(pickedDate);
                        }
                      },
                    ),
                  ],
                );
              }),
              const SizedBox(height: 16),
              Consumer<MedicineRegisterController>(builder: (context, value, child) {
                return value.isLoading
                    ? const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (widget.controller.expirationDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Por favor, selecione a data de validade.')),
                                );
                                return;
                              }
                              value.saveMedicine(context);
                            }
                          },
                          child: const Text('Salvar medicamento'),
                        ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
