import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/utils/validators.dart';
import 'package:remedio_certeiro/presentation/screens/user-register/widgets/register_button_widget.dart';
import 'package:remedio_certeiro/presentation/screens/user-register/widgets/user_register_form_fields_widget.dart';
import 'package:remedio_certeiro/presentation/screens/user-register/user_register_viewmodel.dart';

class UserRegisterView extends StatefulWidget {
  const UserRegisterView({super.key});

  @override
  State<UserRegisterView> createState() => _UserRegisterViewState();
}

class _UserRegisterViewState extends State<UserRegisterView> {
  final formKey = GlobalKey<FormState>();
  late UserRegisterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<UserRegisterViewModel>();
  }

  @override
  void dispose() {
    _viewModel.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validators = Validators();
    return Scaffold(
      appBar: AppBar(title: const Text('Realize seu cadastro')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                UserRegisterFormFieldsWidget(formKey: formKey, validators: validators),
                const SizedBox(height: 32),
                RegisterButtonWidget(formKey: formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
