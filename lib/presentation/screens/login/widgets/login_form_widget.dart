import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/utils/validators.dart';
import 'package:remedio_certeiro/presentation/screens/login/login_viewmodel.dart';

class LoginFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Validators validators;

  const LoginFormWidget({super.key, required this.formKey, required this.validators});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: context.read<LoginViewModel>().setUsername,
                decoration: const InputDecoration(
                  labelText: 'Seu email ou usuário',
                  labelStyle: TextStyle(color: AppColors.textPrimary),
                  prefixIcon: Icon(Icons.person, color: AppColors.textPrimary),
                ),
                textInputAction: TextInputAction.next,
                validator: validators.validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                onChanged: context.read<LoginViewModel>().setPassword,
                decoration: const InputDecoration(
                  labelText: 'Sua senha',
                  labelStyle: TextStyle(color: AppColors.textPrimary),
                  prefixIcon: Icon(Icons.lock, color: AppColors.textPrimary),
                ),
                validator: validators.validatePassword,
              ),
              const SizedBox(height: 32),
              Consumer<LoginViewModel>(
                builder: (context, viewModel, child) {
                  return viewModel.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              viewModel.login(context);
                            }
                          },
                          child: const Text('Entrar'),
                        );
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, Routes.userRegister),
                child: const Text('Cadastrar-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
