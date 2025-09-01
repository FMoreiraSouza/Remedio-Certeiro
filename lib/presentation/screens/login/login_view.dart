import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/utils/validators.dart';
import 'package:remedio_certeiro/presentation/screens/login/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();
    final validators = Validators();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final imageHeight = constraints.maxHeight / 3;
                  return Container(
                    color: AppColors.primary,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('resources/images/app_banner.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      height: imageHeight,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        onChanged: viewModel.setUsername,
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
                        onChanged: viewModel.setPassword,
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
            ),
          ],
        ),
      ),
    );
  }
}
