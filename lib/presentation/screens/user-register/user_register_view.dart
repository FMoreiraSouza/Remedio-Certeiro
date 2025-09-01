import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/utils/validators.dart';
import 'package:remedio_certeiro/presentation/screens/user-register/widgets/register_button_widget.dart';
import 'package:remedio_certeiro/presentation/screens/user-register/widgets/user_register_form_fields_widget.dart';

class UserRegisterView extends StatelessWidget {
  const UserRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final validators = Validators();
    final formKey = GlobalKey<FormState>();

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
