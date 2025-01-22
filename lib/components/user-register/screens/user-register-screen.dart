import 'package:flutter/material.dart';

import 'package:remedio_certeiro/screens-routes.dart';
import 'package:remedio_certeiro/utils/validators.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Validators validationService = Validators();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Realize seu cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Nome
              TextFormField(
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: validationService.validateName,
              ),
              const SizedBox(height: 16),

              // Senha
              TextFormField(
                controller: TextEditingController(),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: validationService.validatePassword,
              ),
              const SizedBox(height: 16),

              // Confirmar Senha
              TextFormField(
                controller: TextEditingController(),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  return validationService.validateConfirmPassword(
                      value, 'senha'); // Passe a senha aqui
                },
              ),
              const SizedBox(height: 16),

              // Idade
              TextFormField(
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: validationService.validateAge,
              ),
              const SizedBox(height: 16),

              // CPF
              TextFormField(
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  prefixIcon: Icon(Icons.credit_card),
                ),
                validator: validationService.validateCpf,
              ),
              const SizedBox(height: 16),

              // Telefone
              TextFormField(
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: validationService.validatePhone,
              ),
              const SizedBox(height: 16),

              // E-mail
              TextFormField(
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: validationService.validateEmail,
              ),
              const SizedBox(height: 32),

              // Botão de Cadastro
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    // Lógica de cadastro
                    final result = await _registerUser(); // Sua lógica de registro aqui
                    if (result != null) {
                      Navigator.pushReplacementNamed(context, ScreensRoutes.home);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Erro ao cadastrar')),
                      );
                    }
                  }
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função de cadastro fictícia
  Future<String?> _registerUser() async {
    // Lógica de cadastro aqui
    return null; // Substitua pelo resultado da sua lógica de cadastro
  }
}
