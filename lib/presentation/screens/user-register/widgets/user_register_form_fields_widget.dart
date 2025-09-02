import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/utils/validators.dart';
import 'package:remedio_certeiro/presentation/screens/user-register/user_register_viewmodel.dart';

class UserRegisterFormFieldsWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Validators validators;

  const UserRegisterFormFieldsWidget({super.key, required this.formKey, required this.validators});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<UserRegisterViewModel>();
    return Column(
      children: [
        TextFormField(
          controller: viewModel.nameController,
          decoration: const InputDecoration(labelText: 'Nome', prefixIcon: Icon(Icons.person)),
          textInputAction: TextInputAction.next,
          validator: validators.validateName,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: viewModel.passwordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Senha', prefixIcon: Icon(Icons.lock)),
          textInputAction: TextInputAction.next,
          validator: validators.validatePassword,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: viewModel.confirmPasswordController,
          obscureText: true,
          decoration:
              const InputDecoration(labelText: 'Confirmar Senha', prefixIcon: Icon(Icons.lock)),
          textInputAction: TextInputAction.next,
          validator: (value) =>
              validators.validateConfirmPassword(value, viewModel.passwordController.text),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: viewModel.ageController,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Idade', prefixIcon: Icon(Icons.calendar_today)),
          textInputAction: TextInputAction.next,
          validator: validators.validateAge,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: viewModel.cpfController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'CPF', prefixIcon: Icon(Icons.credit_card)),
          textInputAction: TextInputAction.next,
          validator: validators.validateCpf,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: viewModel.phoneController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Telefone', prefixIcon: Icon(Icons.phone)),
          textInputAction: TextInputAction.next,
          validator: validators.validatePhone,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: viewModel.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.email)),
          textInputAction: TextInputAction.done,
          validator: validators.validateEmail,
        ),
      ],
    );
  }
}
