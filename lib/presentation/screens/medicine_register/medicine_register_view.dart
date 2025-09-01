import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/medicine_register_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/widgets/date_save_widget.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/widgets/interval_selector_widget.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/widgets/medicine_form_fields_widget.dart';
import 'package:remedio_certeiro/presentation/screens/medicine_register/widgets/spinner_fields_widget.dart';

class MedicineRegisterView extends StatefulWidget {
  const MedicineRegisterView({super.key});

  @override
  State<MedicineRegisterView> createState() => _MedicineRegisterViewState();
}

class _MedicineRegisterViewState extends State<MedicineRegisterView> {
  final formKey = GlobalKey<FormState>();
  late MedicineRegisterViewModel _viewModel; // Armazenar a referência ao ViewModel

  @override
  void initState() {
    super.initState();
    // Obter a instância do ViewModel no initState
    _viewModel = context.read<MedicineRegisterViewModel>();
    // Agendar a chamada de loadData após a construção do widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.loadData();
    });
  }

  @override
  void dispose() {
    _viewModel.clearData(); // Usar a referência armazenada, sem acessar o context
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
                  MedicineFormFieldsWidget(viewModel: viewModel),
                  IntervalSelectorWidget(viewModel: viewModel),
                  SpinnerFieldsWidget(viewModel: viewModel),
                  DateSaveWidget(formKey: formKey, viewModel: viewModel),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
