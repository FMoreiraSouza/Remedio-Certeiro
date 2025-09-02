import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/presentation/screens/medicine-register/medicine_register_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/medicine-register/widgets/date_save_widget.dart';
import 'package:remedio_certeiro/presentation/screens/medicine-register/widgets/interval_selector_widget.dart';
import 'package:remedio_certeiro/presentation/screens/medicine-register/widgets/medicine_form_fields_widget.dart';
import 'package:remedio_certeiro/presentation/screens/medicine-register/widgets/spinner_fields_widget.dart';

class MedicineRegisterView extends StatefulWidget {
  const MedicineRegisterView({super.key});

  @override
  State<MedicineRegisterView> createState() => _MedicineRegisterViewState();
}

class _MedicineRegisterViewState extends State<MedicineRegisterView> {
  final formKey = GlobalKey<FormState>();
  late MedicineRegisterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<MedicineRegisterViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.loadData();
    });
  }

  @override
  void dispose() {
    _viewModel.clearData();
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
                  MedicineFormFieldsWidget(
                    nameController: viewModel.nameController,
                    dosageController: viewModel.dosageController,
                    purposeController: viewModel.purposeController,
                    useModeController: viewModel.useModeController,
                  ),
                  IntervalSelectorWidget(
                    intervalController: viewModel.intervalController,
                    onIntervalChanged: viewModel.setIntervalHours,
                  ),
                  SpinnerFieldsWidget(
                    pharmaceuticalForms: viewModel.pharmaceuticalForms,
                    therapeuticCategories: viewModel.therapeuticCategories,
                    onPharmaceuticalFormSelected: (value) =>
                        viewModel.selectedPharmaceuticalForm = value,
                    onTherapeuticCategorySelected: (value) =>
                        viewModel.selectedTherapeuticCategory = value,
                  ),
                  DateSaveWidget(
                    formKey: formKey,
                    expirationDate: viewModel.expirationDate,
                    isLoading: viewModel.isLoading,
                    onDateSelected: viewModel.setExpirationDate,
                    onSave: () {
                      if (formKey.currentState!.validate() && viewModel.expirationDate != null) {
                        viewModel.saveMedicine(context);
                      } else if (viewModel.expirationDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Por favor, selecione a data de validade.')),
                        );
                      }
                    },
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
