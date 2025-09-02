import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/presentation/screens/user-register/user_register_viewmodel.dart';

class RegisterButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const RegisterButtonWidget({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegisterViewModel>(
      builder: (context, viewModel, child) {
        return viewModel.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    await viewModel.registerUser(context);
                  }
                },
                child: const Text('Cadastrar'),
              );
      },
    );
  }
}
