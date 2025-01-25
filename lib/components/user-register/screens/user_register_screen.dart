import 'package:flutter/material.dart';
import 'package:remedio_certeiro/components/user-register/controllers/user_register_controller.dart';
import 'package:remedio_certeiro/utils/validators.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key, required this.controller});

  final UserRegisterController controller;

  @override
  Widget build(BuildContext context) {
    final Validators validationService = Validators();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Realize seu cadastro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: validationService.validateName,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: validationService.validatePassword,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return validationService.validateConfirmPassword(
                        value, controller.passwordController.text);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Idade',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: validationService.validateAge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.cpfController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    prefixIcon: Icon(Icons.credit_card),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: validationService.validateCpf,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: validationService.validatePhone,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: validationService.validateEmail,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      await controller.registerUser();
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
